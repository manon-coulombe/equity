import 'package:currency_picker/currency_picker.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/screens/compte_details_displaymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final CompteDetailsDisplaymodel compteDetails;

  const TransactionForm({super.key, required this.compteDetails});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final titreController = TextEditingController();
  final montantController = TextEditingController();
  Currency? selectedCurrency;
  List<Currency> currencies = [];
  DateTime selectedDate = DateTime.now();
  late Participant selectedPayeur;
  late Repartition selectedRepartition;
  late Map<Participant, double> repartitions;
  late List<Participant> partitcipants;

  @override
  void initState() {
    super.initState();
    currencies = CurrencyService().getAll();
    montantController.text = '0';
    selectedPayeur = widget.compteDetails.participants.first;
    selectedCurrency = currencies.firstWhere((c) => c.code == widget.compteDetails.currencyCode);
    selectedRepartition = widget.compteDetails.repartitionParDefaut;
    partitcipants = widget.compteDetails.participants;
    repartitions = {for (var participant in partitcipants) participant: 0};
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 7, 25),
      firstDate: DateTime(2021),
      lastDate: DateTime(2022),
    );

    setState(() {
      if (pickedDate != null) {
        selectedDate = pickedDate;
      }
    });
  }

  _setRepartion() {
    if (montantController.text != '0') {
      switch (selectedRepartition) {
        case Repartition.EGALE:
          final montant = double.parse(montantController.text) / partitcipants.length;
          setState(() {
            repartitions = {for (var participant in partitcipants) participant: montant};
          });
        case Repartition.EQUITABLE:
          final double revenusTotal = partitcipants.map((p) => p.revenus).fold(
                0,
                (previous, element) => previous + element,
              );
          setState(() {
            repartitions = {
              for (var participant in partitcipants)
                participant: double.parse(montantController.text) * (participant.revenus / revenusTotal)
            };
          });
        case Repartition.AUTRE:
          return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              'Nouvelle transaction',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 32),
                    CustomTextFormField(
                      controller: titreController,
                      label: 'Titre',
                      errorMessage: 'Saisir le titre',
                    ),
                    SizedBox(height: 24),
                    Text('Montant', style: TextStyle(fontSize: 18)),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                              controller: montantController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez saisir le montant';
                                }
                                return null;
                              },
                              onChanged: (_) {
                                _setRepartion();
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true,
                              )),
                        ),
                        SizedBox(width: 16),
                        SizedBox(
                          width: 120,
                          child: DropdownButtonFormField<Currency>(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              value: selectedCurrency,
                              hint: Text("Choisir une devise"),
                              isExpanded: true,
                              onChanged: (Currency? newValue) {
                                setState(() {
                                  selectedCurrency = newValue;
                                });
                              },
                              items: currencies.map<DropdownMenuItem<Currency>>((currency) {
                                return DropdownMenuItem(
                                  value: currency,
                                  child: Text("${currency.name} (${currency.symbol})"),
                                );
                              }).toList(),
                              selectedItemBuilder: (context) {
                                return currencies.map((currency) {
                                  return Text(
                                    currency.symbol,
                                    style: TextStyle(fontSize: 16),
                                  );
                                }).toList();
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text('Date', style: TextStyle(fontSize: 18)),
                    InkWell(
                      onTap: _selectDate,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(selectedDate),
                              ),
                              Semantics(
                                excludeSemantics: true,
                                child: SvgPicture.asset(
                                  'assets/icons/calendar.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text('Payé par', style: TextStyle(fontSize: 18)),
                    DropdownButtonFormField(
                      value: selectedPayeur,
                      items: widget.compteDetails.participants.map<DropdownMenuItem<Participant>>((participant) {
                        return DropdownMenuItem(
                          value: participant,
                          child: Text(participant.nom),
                        );
                      }).toList(),
                      onChanged: (participant) {
                        if (participant != null) {
                          setState(() {
                            selectedPayeur = participant;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('Répartition', style: TextStyle(fontSize: 18))),
                        SizedBox(
                          width: 160,
                          child: DropdownButtonFormField(
                            value: selectedRepartition,
                            items: Repartition.values.map<DropdownMenuItem<Repartition>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value.label),
                              );
                            }).toList(),
                            onChanged: (repartition) {
                              if (repartition != null) {
                                setState(() {
                                  selectedRepartition = repartition;
                                });
                                _setRepartion();
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        )
                      ],
                    ),
                    ...widget.compteDetails.participants.map(
                      (participant) {
                        return Row(
                          children: [
                            Text(participant.nom),
                            Text(repartitions[participant].toString()),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
