import 'package:currency_picker/currency_picker.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';
import 'package:equity/compte_details/screens/compte_details_displaymodel.dart';
import 'package:equity/compte_details/screens/transaction_details/transaction_form_viewmodel.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
    if (montantController.text.isNotEmpty && montantController.text != '0') {
      final montantTransaction = double.parse(montantController.text.replaceAll(',', '.'));
      switch (selectedRepartition) {
        case Repartition.EGALE:
          final montant = _arrondir(montantTransaction / partitcipants.length);
          setState(() {
            repartitions = {for (var participant in partitcipants) participant: montant};
          });
          break;
        case Repartition.EQUITABLE:
          final double revenusTotal = partitcipants.map((p) => p.revenus).fold(
                0,
                (previous, element) => previous + element,
              );
          setState(() {
            repartitions = {
              for (var participant in partitcipants)
                participant: _arrondir(montantTransaction * (participant.revenus / revenusTotal))
            };
          });
          break;
        case Repartition.AUTRE:
          return;
      }
    } else {
      setState(() {
        repartitions = {for (var participant in partitcipants) participant: 0};
      });
    }
  }

  double _arrondir(double valeur) {
    return (valeur * 100).roundToDouble() / 100;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(253, 221, 219, 1),
          title: Text(
            'Nouvelle transaction',
            style: TextStyle(color: Color.fromRGBO(254, 99, 101, 1), fontWeight: FontWeight.w700),
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
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: montantController,
                            keyboardType: TextInputType.number,
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
                                child: Text(
                                  "${currency.name} (${currency.symbol})",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (context) {
                              return currencies.map((currency) {
                                return Text(
                                  currency.symbol,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                );
                              }).toList();
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Date', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
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
                              style: TextStyle(fontSize: 16),
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
                  SizedBox(height: 8),
                  DropdownButtonFormField(
                    value: selectedPayeur,
                    items: widget.compteDetails.participants.map<DropdownMenuItem<Participant>>((participant) {
                      return DropdownMenuItem(
                        value: participant,
                        child: Text(
                          participant.nom,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                        ),
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
                              child: Text(
                                value.label,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                              ),
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
                  SizedBox(height: 16),
                  ...widget.compteDetails.participants.map(
                    (participant) {
                      return Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    participant.nom,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '${repartitions[participant].toString()} ${selectedCurrency!.symbol}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )),
                          SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 40),
                  StoreConnector<AppState, TransactionFormViewmodel>(
                    distinct: true,
                    converter: (store) => TransactionFormViewmodel.from(store, compteId: widget.compteDetails.id),
                    onDidChange: (oldVm, vm) {
                      if (oldVm?.postTransactionStatus != vm.postTransactionStatus) {
                        if (vm.postTransactionStatus == Status.SUCCESS) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Transaction ajoutée'),
                          ));
                          Navigator.pop(context);
                        } else if (vm.postTransactionStatus == Status.ERROR) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Une erreur est survenue'),
                          ));
                        }
                      }
                    },
                    builder: (context, vm) => Center(
                      child: OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            vm.postTransaction(
                              transaction: Depense(
                                titre: titreController.text,
                                montant: double.parse(montantController.text.replaceAll(',', '.')),
                                deviseCode: selectedCurrency!.code,
                                date: selectedDate,
                                payeur: selectedPayeur,
                                repartition: repartitions,
                              ),
                              compteId: widget.compteDetails.id,
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(MediaQuery.of(context).size.width, 50),
                          backgroundColor: Color.fromRGBO(252, 99, 97, 1),
                        ),
                        child: const Text(
                          'Valider',
                          style: TextStyle(
                              fontSize: 22, color: Color.fromRGBO(253, 221, 219, 1), fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
