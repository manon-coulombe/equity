import 'package:equity/UI/bouton_ajouter.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/screens/compte_formulaire/ajput_participant_bottomsheet.dart';
import 'package:equity/compte_details/screens/compte_formulaire/type_de_compte_card.dart';
import 'package:flutter/material.dart';

class CompteFormScreen extends StatefulWidget {
  const CompteFormScreen({super.key});

  @override
  State<CompteFormScreen> createState() => _CompteFormScreenState();
}

class _CompteFormScreenState extends State<CompteFormScreen> {
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
        backgroundColor: Color.fromRGBO(253, 221, 219, 1),
        title: Text(
          'Nouveau compte Equity',
          style: TextStyle(color: Color.fromRGBO(254, 99, 101, 1), fontWeight: FontWeight.w700),
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
                    errorMessage: 'Saisir le nom du compte',
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
