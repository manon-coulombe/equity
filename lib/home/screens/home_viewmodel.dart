import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:test_project/home/domaine/compte.dart';
import 'package:test_project/redux/app_state.dart';

class HomeViewmodel extends Equatable {
  final List<Compte> comptes;

  const HomeViewmodel({required this.comptes});

  factory HomeViewmodel.from(Store<AppState> store) {
    return HomeViewmodel(comptes: store.state.homeState.comptes);
  }

  @override
  List<Object?> get props => [comptes];
}
