import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:test_project/compte_details/redux/compte_details_redux.dart';
import 'package:test_project/compte_details/screens/compte_details_displaymodel.dart';
import 'package:test_project/redux/app_state.dart';
import 'package:test_project/utils/status.dart';

class CompteDetailsViewmodel extends Equatable {
  final Status status;
  final CompteDetailsDisplaymodel? compteDetails;
  final void Function() fetchCompte;

  const CompteDetailsViewmodel({
    required this.compteDetails,
    required this.status,
    required this.fetchCompte,
  });

  factory CompteDetailsViewmodel.from(Store<AppState> store, {required String compteId}) {
    final compteDetailsState = store.state.comptesDetailsState.mapComptesDetailsStates[compteId];
    return CompteDetailsViewmodel(
      compteDetails: toCompteDetailsDisplaymodel(compteDetailsState?.compteDetails),
      status: compteDetailsState?.status ?? Status.ERROR,
      fetchCompte: () {
        store.dispatch(FetchCompteDetailsAction(compteId));
      },
    );
  }

  @override
  List<Object?> get props => [compteDetails, status];
}
