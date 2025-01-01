import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_project/home/screen/home_screen.dart';
import 'package:test_project/redux/app_state.dart';

class App extends StatelessWidget {
  final Store<AppState> store;

  const App(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
        title: 'Equity',
        home: HomeScreen(),
      ),
    );
  }
}
