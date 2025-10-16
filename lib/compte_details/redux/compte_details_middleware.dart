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
      TypedMiddleware<AppState, PostCompteAction>(middlewares._onPostCompteAction).call,
      TypedMiddleware<AppState, PostTransactionAction>(middlewares._onPostTransactionAction).call,
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
      store.dispatch(ProcessFetchCompteDetailsErrorAction(action.id));
    });
  }

  Future<void> _onPostCompteAction(
      Store<AppState> store,
      PostCompteAction action,
      NextDispatcher next,
      ) async {
    next(action);
    final result = await compteDetailsRepository.postCompte(action.compte);
    result.onSuccess((result) {
      store.dispatch(ProcessPostCompteSuccessAction(compteId: result));
      store.dispatch(FetchComptesAction());
    }).onError((error) {
      store.dispatch(ProcessPostCompteErrorAction());
    });
  }

  Future<void> _onPostTransactionAction(
    Store<AppState> store,
    PostTransactionAction action,
    NextDispatcher next,
  ) async {
    next(action);
    final result = await compteDetailsRepository.postTransaction(action.transaction, action.compteId);
    result.onSuccess((_) {
      store.dispatch(ProcessPostTransactionSuccessAction(compteId: action.compteId));
      //TODO récupérer la transaction pour mettre à jour le state sans fetch
      store.dispatch(FetchCompteDetailsAction(action.compteId));
    }).onError((error) {
      store.dispatch(ProcessPostTransactionErrorAction(compteId: action.compteId));
    });
  }
}
