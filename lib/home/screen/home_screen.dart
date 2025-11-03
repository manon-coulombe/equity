import 'package:equity/UI/bouton_add.dart';
import 'package:equity/compte_details/screens/compte_formulaire/compte_formulaire_screen.dart';
import 'package:equity/home/redux/home_redux.dart';
import 'package:equity/home/screen/compte_card.dart';
import 'package:equity/home/screen/home_viewmodel.dart';
import 'package:equity/redux/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                signUserOut();
              },
              icon: Icon(Icons.logout),
          )
        ],
      ),
      body: StoreConnector<AppState, HomeViewmodel>(
        converter: (store) => HomeViewmodel.from(store),
        onInit: (store) {
          store.dispatch(FetchComptesAction());
        },
        builder: (context, vm) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                SizedBox(height: 24),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: vm.comptes.isNotEmpty
                      ? [
                          ...vm.comptes.map(
                            (compte) => CompteCard(compte),
                          )
                        ]
                      : [Center(child: Text('Pas encore de comptes', style: TextStyle(fontSize: 20)))],
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
