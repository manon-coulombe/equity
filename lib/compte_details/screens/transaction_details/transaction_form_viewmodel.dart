// class TransactionFormViewmodel extends Equatable {
//   final List<Participant> participants;
//   final CompteDetailsDisplaymodel? compteDetails;
//   final void Function() fetchCompte;
//
//   const TransactionFormViewmodel({
//     required this.compteDetails,
//     required this.status,
//     required this.fetchCompte,
//   });
//
//   factory TransactionFormViewmodel.from(Store<AppState> store, {required CompteDetailsDisplaymodel compteId}) {
//     return TransactionFormViewmodel(
//       compteDetails: toCompteDetailsDisplaymodel(compteDetailsState?.compteDetails),
//       status: compteDetailsState?.status ?? Status.ERROR,
//       fetchCompte: () {
//         store.dispatch(FetchCompteDetailsAction(compteId));
//       },
//     );
//   }
//
//   @override
//   List<Object?> get props => [compteDetails, status];
// }
