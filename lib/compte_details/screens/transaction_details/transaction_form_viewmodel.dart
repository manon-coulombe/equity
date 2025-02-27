import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/transaction.dart';
import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:redux/redux.dart';

class TransactionFormViewmodel extends Equatable {
  final Status postTransactionStatus;
  final void Function({required Transaction transaction, required int compteId}) postTransaction;

  const TransactionFormViewmodel({required this.postTransaction, required this.postTransactionStatus});

  factory TransactionFormViewmodel.from(Store<AppState> store, {required int compteId}) {
    return TransactionFormViewmodel(
      postTransactionStatus:
          store.state.comptesDetailsState.mapComptesDetailsStates[compteId]?.postTransactionStatus ?? Status.NOT_LOADED,
      postTransaction: ({required Transaction transaction, required int compteId}) {
        store.dispatch(PostTransactionAction(transaction: transaction, compteId: compteId));
      },
    );
  }

  @override
  List<Object?> get props => [postTransactionStatus];
}
