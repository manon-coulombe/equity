import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_project/home/screens/home_screen.dart';
import 'package:test_project/redux/app_state.dart';

class App extends StatelessWidget {
  final Store<AppState> store;

  const App(this.store, {super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: const MaterialApp(
        title: 'Pokemon',
        home: HomeScreen(),
      ),
    );
  }
}