
import 'package:flutter/material.dart';
import 'package:test_project/UI/custom_text_form_field.dart';

class AjoutParticipantBottomsheet extends StatefulWidget {
  const AjoutParticipantBottomsheet({
    super.key,
  });

  @override
  State<AjoutParticipantBottomsheet> createState() => _AjoutParticipantBottomsheetState();
}

class _AjoutParticipantBottomsheetState extends State<AjoutParticipantBottomsheet> {
  final _nomController = TextEditingController();
  final _revenusController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
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
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              CustomTextFormField(
                label: 'Nom',
                controller: _nomController,
              ),
              SizedBox(height: 32),
              CustomTextFormField(
                label: 'Revenus nets par mois',
                controller: _revenusController,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  //ajout participant action
                  Navigator.pop(context);
                },
                child: const Text('Ajouter', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}