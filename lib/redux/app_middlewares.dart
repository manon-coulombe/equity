import 'package:equity/compte_details/data/compte_details_repository.dart';
import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/home/data/home_repository.dart';
import 'package:equity/home/redux/home_redux.dart';
import 'package:equity/redux/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAppMiddlewares({
  required IHomeRepository homeRepository,
  required ICompteDetailsRepository compteDetailsRepository,
}) {
  return [
    ...HomeMiddlewares.create(homeRepository),
    ...CompteDetailsMiddlewares.create(compteDetailsRepository)
  ];
}
