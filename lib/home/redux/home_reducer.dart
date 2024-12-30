part of 'home_redux.dart';

class HomeReducers {
  static List<Reducer<AppState>> create() {
    return [
      TypedReducer<AppState, FetchComptesAction>(
        HomeReducers._onFetchComptesAction,
      ).call,
      TypedReducer<AppState, ProcessFetchComptesSuccessAction>(
        HomeReducers._onProcessFetchComptesSuccessAction,
      ).call,
      TypedReducer<AppState, ProcessFetchComptesErrorAction>(
        HomeReducers._onProcessFetchComptesErrorAction,
      ).call,
    ];
  }

  static AppState _onFetchComptesAction(
    AppState state,
    FetchComptesAction action,
  ) {
    return state.clone(homeState: state.homeState.clone(status: Status.LOADING));
  }

  static AppState _onProcessFetchComptesSuccessAction(
    AppState state,
    ProcessFetchComptesSuccessAction action,
  ) {
    return state.clone(homeState: state.homeState.clone(status: Status.SUCCESS, comptes: action.comptes));
  }

  static AppState _onProcessFetchComptesErrorAction(
    AppState state,
    ProcessFetchComptesErrorAction action,
  ) {
    return state.clone(homeState: state.homeState.clone(status: Status.ERROR));
  }
}
