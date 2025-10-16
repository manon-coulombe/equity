import 'package:equity/UI/bouton_add.dart';
import 'package:equity/compte_details/screens/compte_formulaire/compte_formulaire_screen.dart';
import 'package:equity/home/redux/home_redux.dart';
import 'package:equity/home/screen/compte_card.dart';
import 'package:equity/home/screen/home_viewmodel.dart';
import 'package:equity/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Scaffold(
      body: StoreConnector<AppState, HomeViewmodel>(
        converter: (store) => HomeViewmodel.from(store),
        onInit: (store) {
          store.dispatch(FetchComptesAction());
        },
        builder: (context, vm) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                SizedBox(height: 80),
                Text(
                  'equity',
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900, fontFamily: 'Mplus'),
                ),
                SizedBox(height: 40),
                BoutonAdd(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CompteFormScreen()),
                    );
                  },
                ),
                SizedBox(height: 32),
                ...vm.comptes.map(
                  (compte) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CompteCard(compte),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
