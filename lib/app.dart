import 'package:equity/auth_screen.dart';
import 'package:equity/home/screen/home_screen.dart';
import 'package:equity/login_screen.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final Store<AppState> store;

  const App(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(255, 246, 245, 1),
          fontFamily: 'Raleway',
          useMaterial3: true,
        ),
        title: 'Equity',
        home: AuthScreen(),
      ),
    );
  }
}
