import 'package:equatable/equatable.dart';
import 'package:test_project/compte_details/redux/compte_details_redux.dart';
import 'package:test_project/home/redux/home_redux.dart';

class AppState extends Equatable {
  final HomeState homeState;
  final ComptesDetailsState comptesDetailsState;

  const AppState({
    required this.homeState,
    required this.comptesDetailsState,
  });

  AppState clone({HomeState? homeState, ComptesDetailsState? comptesDetailsState}) {
    return AppState(
      homeState: homeState ?? this.homeState,
      comptesDetailsState: comptesDetailsState ?? this.comptesDetailsState,
    );
  }

  @override
  List<Object?> get props => [homeState, comptesDetailsState];
}
