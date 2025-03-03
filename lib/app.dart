import 'package:equity/home/screen/home_screen.dart';
import 'package:equity/redux/app_state.dart';
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
        theme: ThemeData(
          fontFamily: 'Raleway',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xfffddddb),
            brightness: Brightness.light,
          ),
        ),
        title: 'Equity',
        home: HomeScreen(),
      ),
    );
  }
}
