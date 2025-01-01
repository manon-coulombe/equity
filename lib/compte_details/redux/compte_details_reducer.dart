part of 'compte_details_redux.dart';

class CompteDetailsReducers {
  static List<Reducer<AppState>> create() {
    return [
      TypedReducer<AppState, FetchCompteDetailsAction>(
        CompteDetailsReducers._onFetchCompteDetailsAction,
      ).call,
      TypedReducer<AppState, ProcessFetchCompteDetailsSuccessAction>(
        CompteDetailsReducers._onProcessFetchCompteDetailsSuccessAction,
      ).call,
      TypedReducer<AppState, ProcessFetchCompteDetailsErrorAction>(
        CompteDetailsReducers._onProcessFetchCompteDetailsErrorAction,
      ).call,
    ];
  }

  static AppState _onFetchCompteDetailsAction(
    AppState state,
    FetchCompteDetailsAction action,
  ) {
    final compte = state.comptesDetailsState.compteDetails[action.id];

    return state.clone(comptesDetailsState: state.comptesDetailsState.clone(status: Status.LOADING));
  }

  static AppState _onProcessFetchCompteDetailsSuccessAction(
    AppState state,
    ProcessFetchCompteDetailsSuccessAction action,
  ) {
    return state.clone(homeState: state.homeState.clone(status: Status.SUCCESS, comptes: action.compteDetails));
  }

  static AppState _onProcessFetchCompteDetailsErrorAction(
    AppState state,
    ProcessFetchCompteDetailsErrorAction action,
  ) {
    return state.clone(homeState: state.homeState.clone(status: Status.ERROR));
  }
}
