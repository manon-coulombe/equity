import 'package:redux/redux.dart';
import 'package:test_project/home/data/home_repository.dart';
import 'package:test_project/home/redux/home_redux.dart';
import 'package:test_project/redux/app_state.dart';

List<Middleware<AppState>> createAppMiddlewares({
  required IHomeRepository homeRepository,
}) {
  return [
    ...HomeMiddlewares.create(homeRepository),
  ];
}
