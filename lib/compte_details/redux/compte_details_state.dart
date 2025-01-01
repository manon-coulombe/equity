part of 'compte_details_redux.dart';

class ComptesDetailsState extends Equatable {
  final Map<String, CompteDetails> compteDetails;

  const ComptesDetailsState({
    this.compteDetails = const {},
  });

  @override
  List<Object?> get props => [compteDetails];
}

class CompteDetailsState extends Equatable {
  final Status status;
  final CompteDetails? compteDetails;

  const CompteDetailsState({
    this.status = Status.NOT_LOADED,
    this.compteDetails,
  });

  CompteDetailsState clone({
    Status? status,
    CompteDetails? compteDetails,
  }) {
    return CompteDetailsState(
      status: status ?? this.status,
      compteDetails: compteDetails ?? this.compteDetails,
    );
  }

  @override
  List<Object?> get props => [status, compteDetails];
}