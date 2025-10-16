import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:redux/redux.dart';

class CompteFormViewmodel extends Equatable {
  final void Function(CompteDetails compte) postCompte;
  final Status postCompteStatus;
  final int? postedCompteId;

  const CompteFormViewmodel({required this.postCompte, required this.postCompteStatus, required this.postedCompteId});

  factory CompteFormViewmodel.from(Store<AppState> store) {
    return CompteFormViewmodel(
      postCompte: (CompteDetails compte) {
        store.dispatch(PostCompteAction(compte));
      },
      postCompteStatus: store.state.comptesDetailsState.postCompteStatus,
      postedCompteId: store.state.comptesDetailsState.lastPostedCompteId,
    );
  }

  @override
  List<Object?> get props => [postCompteStatus, postedCompteId];
}
