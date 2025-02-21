import 'package:equity/app.dart';
import 'package:equity/compte_details/data/compte_details_repository.dart';
import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/home/data/home_repository.dart';
import 'package:equity/home/redux/home_redux.dart';
import 'package:equity/redux/app_middlewares.dart';
import 'package:equity/redux/app_reducers.dart';
import 'package:equity/redux/app_state.dart';
import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    appReducers,
    middleware: createAppMiddlewares(
      homeRepository: HomeRepository(),
      compteDetailsRepository: CompteDetailsRepository(),
    ),
    initialState: AppState(
        homeState: HomeState(), comptesDetailsState: ComptesDetailsState()),
  );
  runApp(App(store));
}
