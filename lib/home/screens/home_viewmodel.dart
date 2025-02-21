import 'package:equatable/equatable.dart';
import 'package:equity/home/domain/compte.dart';
import 'package:equity/redux/app_state.dart';
import 'package:redux/redux.dart';

class HomeViewmodel extends Equatable {
  final List<Compte> comptes;

  const HomeViewmodel({required this.comptes});

  factory HomeViewmodel.from(Store<AppState> store) {
    return HomeViewmodel(comptes: store.state.homeState.comptes);
  }

  @override
  List<Object?> get props => [comptes];
}
