import 'package:redux/redux.dart';
import 'package:test_project/compte_details/redux/compte_details_redux.dart';
import 'package:test_project/home/redux/home_redux.dart';
import 'package:test_project/redux/app_state.dart';

final appReducers = combineReducers<AppState>([
  ...HomeReducers.create(),
  ...CompteDetailsReducers.create(),
]);
