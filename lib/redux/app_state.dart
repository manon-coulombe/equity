import 'package:equatable/equatable.dart';
import 'package:test_project/home/redux/home_redux.dart';

class AppState extends Equatable {
  final HomeState homeState;

  const AppState({
    required this.homeState,
  });

  AppState clone({
    HomeState? homeState,
  }) {
    return AppState(homeState: homeState ?? this.homeState);
  }

  @override
  List<Object?> get props => [homeState];
}
