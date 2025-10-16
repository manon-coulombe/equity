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
      TypedReducer<AppState, PostCompteAction>(
        CompteDetailsReducers._onPostCompteAction,
      ).call,
      TypedReducer<AppState, ProcessPostCompteSuccessAction>(
        CompteDetailsReducers._onProcessPostCompteSuccessAction,
      ).call,
      TypedReducer<AppState, ProcessPostCompteErrorAction>(
        CompteDetailsReducers._onProcessPostCompteErrorAction,
      ).call,
      TypedReducer<AppState, PostTransactionAction>(
        CompteDetailsReducers._onPostTransactionAction,
      ).call,
      TypedReducer<AppState, ProcessPostTransactionSuccessAction>(
        CompteDetailsReducers._onProcessPostTransactionSuccessAction,
      ).call,
      TypedReducer<AppState, ProcessPostTransactionErrorAction>(
        CompteDetailsReducers._onProcessPostTransactionErrorAction,
      ).call,
    ];
  }

  static AppState _onFetchCompteDetailsAction(
    AppState state,
    FetchCompteDetailsAction action,
  ) {
    final Map<int, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);
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
    final Map<int, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);
    map[action.compteDetails.id!] = CompteDetailsState(status: Status.SUCCESS, compteDetails: action.compteDetails);
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }

  static AppState _onProcessFetchCompteDetailsErrorAction(
    AppState state,
    ProcessFetchCompteDetailsErrorAction action,
  ) {
    final Map<int, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);
    if (map[action.id] == null) {
      map[action.id] = CompteDetailsState(status: Status.ERROR);
    } else {
      map[action.id]!.clone(status: Status.ERROR);
    }
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }

  static AppState _onPostCompteAction(
    AppState state,
    PostCompteAction action,
  ) {
    return state.clone(comptesDetailsState: ComptesDetailsState(postCompteStatus: Status.LOADING));
  }

  static AppState _onProcessPostCompteSuccessAction(
    AppState state,
    ProcessPostCompteSuccessAction action,
  ) {
    return state.clone(
      comptesDetailsState: state.comptesDetailsState.clone(
        postCompteStatus: Status.SUCCESS,
        lastPostedCompteId: action.compteId,
      ),
    );
  }

  static AppState _onProcessPostCompteErrorAction(
    AppState state,
    ProcessPostCompteErrorAction action,
  ) {
    return state.clone(comptesDetailsState: ComptesDetailsState(postCompteStatus: Status.ERROR));
  }

  static AppState _onPostTransactionAction(
    AppState state,
    PostTransactionAction action,
  ) {
    final Map<int, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);

    final compte = map[action.compteId];
    if (compte == null) {
      return state;
    } else {
      compte.clone(postTransactionStatus: Status.LOADING);
    }
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }

  static AppState _onProcessPostTransactionSuccessAction(
    AppState state,
    ProcessPostTransactionSuccessAction action,
  ) {
    final Map<int, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);

    if (map[action.compteId] == null) {
      return state;
    } else {
      map[action.compteId] = map[action.compteId]!.clone(postTransactionStatus: Status.SUCCESS);
    }
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }

  static AppState _onProcessPostTransactionErrorAction(
    AppState state,
    ProcessPostTransactionErrorAction action,
  ) {
    final Map<int, CompteDetailsState> map = Map.from(state.comptesDetailsState.mapComptesDetailsStates);

    final compte = map[action.compteId];
    if (compte == null) {
      return state;
    } else {
      compte.clone(postTransactionStatus: Status.ERROR);
    }
    return state.clone(comptesDetailsState: ComptesDetailsState(mapComptesDetailsStates: map));
  }
}
