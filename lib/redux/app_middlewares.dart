import 'package:redux/redux.dart';
import 'package:test_project/compte_details/data/compte_details_repository.dart';
import 'package:test_project/compte_details/redux/compte_details_redux.dart';
import 'package:test_project/home/data/home_repository.dart';
import 'package:test_project/home/redux/home_redux.dart';
import 'package:test_project/redux/app_state.dart';

List<Middleware<AppState>> createAppMiddlewares({
  required IHomeRepository homeRepository,
  required ICompteDetailsRepository compteDetailsRepository,
}) {
  return [
    ...HomeMiddlewares.create(homeRepository),
    ...CompteDetailsMiddlewares.create(compteDetailsRepository)
  ];
}
