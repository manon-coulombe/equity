import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/transaction.dart';
import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:redux/redux.dart';

class TransactionFormViewmodel extends Equatable {
  final Status postTransactionStatus;
  final void Function({required Transaction transaction, required int compteId}) validate;

  const TransactionFormViewmodel({required this.validate, required this.postTransactionStatus});

  factory TransactionFormViewmodel.from(Store<AppState> store, {required int compteId}) {
    return TransactionFormViewmodel(
      postTransactionStatus:
          store.state.comptesDetailsState.mapComptesDetailsStates[compteId]?.postOrDeleteTransactionStatus ?? Status.NOT_LOADED,
      validate: ({required Transaction transaction, required int compteId}) {
        if (transaction.id == null) {
        store.dispatch(PostTransactionAction(transaction: transaction, compteId: compteId));
          
        } else {
          //TODO
        }
      },
    );
  }

  @override
  List<Object?> get props => [postTransactionStatus];
}
