import 'package:flutter/widgets.dart';
import 'package:redux/redux.dart';
import 'package:test_project/app.dart';
import 'package:test_project/home/data/home_repository.dart';
import 'package:test_project/home/redux/home_redux.dart';
import 'package:test_project/redux/app_middlewares.dart';
import 'package:test_project/redux/app_reducers.dart';
import 'package:test_project/redux/app_state.dart';

void main() {
  final homeRepository = HomeRepository();
  final store = Store<AppState>(
    appReducers,
    middleware: createAppMiddlewares(homeRepository: homeRepository),
    initialState: AppState(homeState: HomeState()),
  );
  runApp(App(store));
}
