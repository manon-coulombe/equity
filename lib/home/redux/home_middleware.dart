part of 'home_redux.dart';

class HomeMiddlewares {
  final IHomeRepository homeRepository;

  HomeMiddlewares(this.homeRepository);

  static List<Middleware<AppState>> create(
    IHomeRepository homeRepository,
  ) {
    final middlewares = HomeMiddlewares(homeRepository);
    return [
      TypedMiddleware<AppState, FetchComptesAction>(
              middlewares._onFetchComptesAction)
          .call,
    ];
  }

  Future<void> _onFetchComptesAction(
    Store<AppState> store,
    FetchComptesAction action,
    NextDispatcher next,
  ) async {
    next(action);
    final result = await homeRepository.getComptes();
    result.onSuccess((result) {
      store.dispatch(ProcessFetchComptesSuccessAction(result));
    }).onError((error) {
      store.dispatch(ProcessFetchComptesErrorAction());
    });
  }
}
