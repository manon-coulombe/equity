import 'package:equity/UI/bouton_add.dart';
import 'package:equity/auth/auth_service.dart';
import 'package:equity/compte_details/screens/compte_formulaire/compte_formulaire_screen.dart';
import 'package:equity/home/screen/compte_card.dart';
import 'package:equity/home/screen/home_viewmodel.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void signUserOut() {
    authService.value.logOut();
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
          ),
        ],
      ),
      body: StoreConnector<AppState, HomeViewmodel>(
        converter: (store) => HomeViewmodel.from(store),
        onInitialBuild: (vm) {
          vm.fetchComptes();
        },
        builder: (context, vm) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RefreshIndicator(
            onRefresh: () => vm.fetchComptes(),
            child: SingleChildScrollView(
              controller: controller,
              physics: AlwaysScrollableScrollPhysics(),
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
                    children: [
                      if (vm.status == Status.LOADING)
                        Center(
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: CircularProgressIndicator(color: Color.fromRGBO(106, 208, 153, 1), strokeWidth: 6),
                          ),
                        )
                      else if (vm.status == Status.SUCCESS)
                        if (vm.comptes.isNotEmpty)
                          ...vm.comptes.map(
                            (compte) => CompteCard(compte),
                          )
                        else
                          Center(child: Text('Pas encore de comptes', style: TextStyle(fontSize: 20)))
                      else
                        Center(
                          child: Text('Une erreur est survenue', style: TextStyle(fontSize: 16)),
                        ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
