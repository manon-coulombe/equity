part of 'compte_details_redux.dart';

class CompteDetailsMiddlewares {
  final ICompteDetailsRepository compteDetailsRepository;

  CompteDetailsMiddlewares(this.compteDetailsRepository);

  static List<Middleware<AppState>> create(
      ICompteDetailsRepository compteDetailsRepository,
  ) {
    final middlewares = CompteDetailsMiddlewares(compteDetailsRepository);
    return [
      TypedMiddleware<AppState, FetchCompteDetailsAction>(middlewares._onFetchCompteDetailsAction).call,
    ];
  }

  Future<void> _onFetchCompteDetailsAction(
    Store<AppState> store,
    FetchCompteDetailsAction action,
    NextDispatcher next,
  ) async {
    next(action);
    final result = await compteDetailsRepository.getCompteDetails(action.id);
    result.onSuccess((result) {
      store.dispatch(ProcessFetchCompteDetailsSuccessAction(result));
    }).onError((error) {
      store.dispatch(ProcessFetchCompteDetailsErrorAction());
    });
  }
}
