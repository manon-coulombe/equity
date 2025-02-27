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

class PostTransactionAction {
  final Transaction transaction;
  final int compteId;

  PostTransactionAction({required this.transaction, required this.compteId});
}

class ProcessPostTransactionSuccessAction {
  final int compteId;

  ProcessPostTransactionSuccessAction({required this.compteId});
}

class ProcessPostTransactionErrorAction {
  final int compteId;

  ProcessPostTransactionErrorAction({required this.compteId});
}
