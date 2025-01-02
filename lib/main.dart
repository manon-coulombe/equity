import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:test_project/app.dart';
import 'package:test_project/compte_details/data/compte_details_repository.dart';
import 'package:test_project/compte_details/redux/compte_details_redux.dart';
import 'package:test_project/home/data/home_repository.dart';
import 'package:test_project/home/redux/home_redux.dart';
import 'package:test_project/redux/app_middlewares.dart';
import 'package:test_project/redux/app_reducers.dart';
import 'package:test_project/redux/app_state.dart';

void main() {
  final store = Store<AppState>(
    appReducers,
    middleware: createAppMiddlewares(
      homeRepository: HomeRepository(),
      compteDetailsRepository: CompteDetailsRepository(),
    ),
    initialState: AppState(homeState: HomeState(), comptesDetailsState: ComptesDetailsState()),
  );
  runApp(App(store));
}
