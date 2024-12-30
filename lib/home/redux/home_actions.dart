part of 'home_redux.dart';

class FetchComptesAction {}

class ProcessFetchComptesSuccessAction {
  final List<Compte> comptes;

  const ProcessFetchComptesSuccessAction(this.comptes);
}

class ProcessFetchComptesErrorAction {}
