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
    final Map<String, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);
    CompteDetailsState? compteState = map[action.id];
    if (compteState != null && compteState.status == Status.SUCCESS) {
      return state;
    }
    map[action.id] = CompteDetailsState(status: Status.LOADING);
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }

  static AppState _onProcessFetchCompteDetailsSuccessAction(
    AppState state,
    ProcessFetchCompteDetailsSuccessAction action,
  ) {
    final Map<String, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);
    map[action.compteDetails.id] = CompteDetailsState(status: Status.SUCCESS, compteDetails: action.compteDetails);
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }

  static AppState _onProcessFetchCompteDetailsErrorAction(
    AppState state,
    ProcessFetchCompteDetailsErrorAction action,
  ) {
    final Map<String, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);
    if (map[action.id] == null) {
      map[action.id] = CompteDetailsState(status: Status.ERROR);
    }
    map[action.id]!.clone(status: Status.ERROR);
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }
}
