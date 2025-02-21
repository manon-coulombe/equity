part of 'compte_details_redux.dart';

class FetchCompteDetailsAction {
  final int id;

  FetchCompteDetailsAction(this.id);
}

class ProcessFetchCompteDetailsSuccessAction {
  final CompteDetails compteDetails;

  const ProcessFetchCompteDetailsSuccessAction(this.compteDetails);
}

class ProcessFetchCompteDetailsErrorAction {
  final int id;

  ProcessFetchCompteDetailsErrorAction(this.id);
}
