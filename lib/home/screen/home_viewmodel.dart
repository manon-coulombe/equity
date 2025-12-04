import 'package:equatable/equatable.dart';
import 'package:equity/home/domain/compte.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:redux/redux.dart';

class HomeViewmodel extends Equatable {
  final List<Compte> comptes;
  final Status status;

  const HomeViewmodel({required this.comptes, required this.status});

  factory HomeViewmodel.from(Store<AppState> store) {
    return HomeViewmodel(
      comptes: store.state.homeState.comptes,
      status: store.state.homeState.status,
    );
  }

  @override
  List<Object?> get props => [comptes, status];
}
