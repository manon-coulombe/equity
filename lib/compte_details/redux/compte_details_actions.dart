part of 'compte_details_redux.dart';

class FetchCompteDetailsAction {
  final String id;

  FetchCompteDetailsAction(this.id);
}

class ProcessFetchCompteDetailsSuccessAction {
  final CompteDetails compteDetails;

  const ProcessFetchCompteDetailsSuccessAction(this.compteDetails);
}

class ProcessFetchCompteDetailsErrorAction {
  final String id;

  ProcessFetchCompteDetailsErrorAction(this.id);
}
