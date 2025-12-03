import 'package:equity/UI/button_validate.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AjoutParticipantBottomsheet extends StatefulWidget {
  const AjoutParticipantBottomsheet({
    super.key,
  });

  @override
  State<AjoutParticipantBottomsheet> createState() => _AjoutParticipantBottomsheetState();
}

class _AjoutParticipantBottomsheetState extends State<AjoutParticipantBottomsheet> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _revenusController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox.expand(
        child: Center(
          child: Container(
            color: Color.fromRGBO(255, 246, 245, 1),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Nouvelle·au participant·e',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 28),
                CustomTextFormField(
                  label: 'Nom',
                  controller: _nomController,
                  emptyErrorMessage: 'Saisir le nom',
                ),
                SizedBox(height: 4),
                CustomTextFormField(
                  label: 'Revenus nets par mois',
                  controller: _revenusController,
                  emptyErrorMessage: 'Saisir les revenus',
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
                  ],
                ),
                SizedBox(height: 8),
                ButtonValidate(
                  onValidate: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(
                        context,
                        Participant(nom: _nomController.text, revenus: double.parse(_revenusController.text)),
                      );
                    }
                  },
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
