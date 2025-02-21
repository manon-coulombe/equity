import 'package:equity/UI/bouton_ajouter.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/screens/compte_formulaire/ajput_participant_bottomsheet.dart';
import 'package:equity/compte_details/screens/compte_formulaire/type_de_compte_card.dart';
import 'package:flutter/material.dart';

class CompteFormulaireScreen extends StatefulWidget {
  const CompteFormulaireScreen({super.key});

  @override
  State<CompteFormulaireScreen> createState() => _CompteFormulaireScreenState();
}

class _CompteFormulaireScreenState extends State<CompteFormulaireScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Nouveau compte Equity',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TypeDeCompteCard(label: 'Couple'),
                      TypeDeCompteCard(label: 'Colocation'),
                      TypeDeCompteCard(label: 'Voyage'),
                      TypeDeCompteCard(label: 'Projet'),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomTextFormField(
                    controller: _nomController,
                    label: 'Nom du compte',
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text('Participant·e·s', style: TextStyle(fontSize: 18)),
                      SizedBox(width: 8),
                      BoutonAjouter(
                        size: 28,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AjoutParticipantBottomsheet();
                            },
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
