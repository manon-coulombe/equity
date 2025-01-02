import 'package:equatable/equatable.dart';
import 'package:test_project/compte_details/domain/compte_details.dart';
import 'package:intl/intl.dart';
import 'package:test_project/compte_details/domain/transaction.dart';

class CompteDetailsDisplaymodel extends Equatable {
  final String id;
  final String titre;
  final String formattedTotal;
  final String formattedBalance;
  final List<TransactionDisplaymodel> transactionsDisplaymodels;

  const CompteDetailsDisplaymodel({
    required this.id,
    required this.titre,
    required this.formattedTotal,
    required this.formattedBalance,
    required this.transactionsDisplaymodels,
  });

  @override
  List<Object?> get props => [id, titre, formattedTotal, formattedBalance, transactionsDisplaymodels];
}

class TransactionDisplaymodel extends Equatable {
  final String id;
  final String titre;
  final String formattedDate;
  final String formattedMontant;

  const TransactionDisplaymodel({
    required this.id,
    required this.titre,
    required this.formattedDate,
    required this.formattedMontant,
  });

  @override
  List<Object?> get props => [id, titre, formattedDate, formattedMontant];
}

CompteDetailsDisplaymodel? toCompteDetailsDisplaymodel(CompteDetails? compte) {
  return compte == null
      ? null
      : CompteDetailsDisplaymodel(
          id: compte.id,
          titre: compte.nom,
          formattedTotal: '${compte.totalDepenses} ${compte.deviseCode}',
          formattedBalance: 'formattedBalance',
          transactionsDisplaymodels: compte.transactions.map((trs) => toTransactionDisplaymodel(trs)).toList(),
        );
}

TransactionDisplaymodel toTransactionDisplaymodel(Transaction transaction) {
  return TransactionDisplaymodel(
    id: transaction.id,
    titre: transaction.titre,
    formattedDate: DateFormat('yyyy-MM-dd').format(transaction.date),
    formattedMontant: '${transaction.montant} ${transaction.deviseCode}',
  );
}
