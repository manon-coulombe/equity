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

class PostCompteAction {
  final CompteDetails compte;

  PostCompteAction(this.compte);
}

class ProcessPostCompteSuccessAction {
  final int compteId;

  ProcessPostCompteSuccessAction({required this.compteId});
}

class ProcessPostCompteErrorAction {}

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

class DeleteTransactionAction {
  final int transactionId;
  final int compteId;

  DeleteTransactionAction({required this.transactionId, required this.compteId});
}

class ProcessDeleteTransactionSuccessAction {
  final int compteId;

  ProcessDeleteTransactionSuccessAction({required this.compteId});
}

class ProcessDeleteTransactionErrorAction {
  final int compteId;

  ProcessDeleteTransactionErrorAction({required this.compteId});
}
