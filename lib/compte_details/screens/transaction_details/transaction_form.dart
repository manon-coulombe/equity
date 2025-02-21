import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  Currency? selectedCurrency; // Devise sélectionnée
  List<Currency> currencies = [];

  DateTime selectedDate = DateTime.now();

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

  @override
  void initState() {
    super.initState();
    currencies = CurrencyService().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Nouvelle transaction',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 32),
              Text('Titre'),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le titre';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Montant'),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez saisir le titre';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<Currency>(
                      value: selectedCurrency,
                      hint: Text("Choisir une devise"),
                      isExpanded: true,
                      onChanged: (Currency? newValue) {
                        setState(() {
                          selectedCurrency = newValue;
                        });
                      },
                      items: currencies.map<DropdownMenuItem<Currency>>((Currency currency) {
                        return DropdownMenuItem<Currency>(
                          value: currency,
                          child: Text("${currency.name} (${currency.symbol})"),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text('Date'),
              InkWell(
                onTap: _selectDate,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
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
    );
  }
}
