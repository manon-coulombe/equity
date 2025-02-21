import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/home/redux/home_redux.dart';
import 'package:equity/redux/app_state.dart';
import 'package:redux/redux.dart';

final appReducers = combineReducers<AppState>([
  ...HomeReducers.create(),
  ...CompteDetailsReducers.create(),
]);
