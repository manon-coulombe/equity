import 'package:equity/UI/bouton_add.dart';
import 'package:equity/UI/custom_text_form_field.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
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
  TypeDeCompte? _selectedTypeDeCompte;
  List<Participant> participants = [];

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: TypeDeCompte.values
                        .map((type) => TypeDeCompteCard(
                              label: type.label,
                              isSelected: _selectedTypeDeCompte == type,
                              select: () {
                                setState(() {
                                  _selectedTypeDeCompte = type;
                                });
                              },
                            ))
                        .toList(),
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
                      BoutonAdd(
                        size: 28,
                        onTap: () async {
                          final participant = await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return AjoutParticipantBottomsheet();
                            },
                          );
                          setState(() {
                            participants.add(participant);
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: participants.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              participants[i].nom,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(participants[i].revenus.toString()),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, i) => Divider(),
                    ),
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
