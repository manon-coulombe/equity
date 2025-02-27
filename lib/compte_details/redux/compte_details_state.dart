part of 'compte_details_redux.dart';

class ComptesDetailsState extends Equatable {
  final Map<int, CompteDetailsState> mapComptesDetailsStates;

  const ComptesDetailsState({
    this.mapComptesDetailsStates = const {},
  });

  @override
  List<Object?> get props => [mapComptesDetailsStates];
}

class CompteDetailsState extends Equatable {
  final Status status;
  final CompteDetails? compteDetails;
  final Status postTransactionStatus;

  const CompteDetailsState({
    this.status = Status.NOT_LOADED,
    this.compteDetails,
    this.postTransactionStatus = Status.NOT_LOADED,
  });

  CompteDetailsState clone({
    Status? status,
    Status? postTransactionStatus,
    CompteDetails? compteDetails,
  }) {
    return CompteDetailsState(
      status: status ?? this.status,
      postTransactionStatus: postTransactionStatus ?? this.postTransactionStatus,
      compteDetails: compteDetails ?? this.compteDetails,
    );
  }

  @override
  List<Object?> get props => [status, compteDetails, postTransactionStatus];
}
