import 'package:equity/UI/button_validate.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:flutter/material.dart';

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
          child: Padding(
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
                SizedBox(height: 32),
                CustomTextFormField(
                  label: 'Nom',
                  controller: _nomController,
                  errorMessage: 'Saisir le nom',
                ),
                SizedBox(height: 32),
                CustomTextFormField(
                  label: 'Revenus nets par mois',
                  controller: _revenusController,
                  errorMessage: 'Saisir les revenus',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 32),
                ButtonValidate(
                  onValidate: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(
                        context,
                        Participant(nom: _nomController.text, revenus: double.parse(_revenusController.text)),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
