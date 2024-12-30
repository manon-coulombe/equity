import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/home/screens/home_viewmodel.dart';
import 'package:test_project/redux/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('EQUITY'),
        centerTitle: true,
      ),
      body: StoreConnector<AppState, HomeViewmodel>(
        converter: (store) => HomeViewmodel.from(store),
        builder: (context, vm) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
              SizedBox(height: 48),
              Card(
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Voyage à Marseille'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
