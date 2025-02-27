import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';
import 'package:intl/intl.dart';

class CompteDetailsDisplaymodel extends Equatable {
  final int id;
  final String titre;
  final String formattedTotal;
  final String formattedBalance;
  final List<TransactionDisplaymodel> transactionsDisplaymodels;
  final List<Participant> participants;
  final String currencyCode;
  final Repartition repartitionParDefaut;

  const CompteDetailsDisplaymodel({
    required this.id,
    required this.titre,
    required this.formattedTotal,
    required this.formattedBalance,
    required this.transactionsDisplaymodels,
    required this.participants,
    required this.currencyCode,
    required this.repartitionParDefaut,
  });

  @override
  List<Object?> get props => [
        id,
        titre,
        formattedTotal,
        formattedBalance,
        transactionsDisplaymodels,
        participants,
      ];
}

class TransactionDisplaymodel extends Equatable {
  final int? id;
  final String titre;
  final String formattedDate;
  final String formattedMontant;

  const TransactionDisplaymodel({
    this.id,
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
          formattedTotal: '${compte.totalDepenses} ${compte.currencyCode}',
          formattedBalance: 'formattedBalance',
          transactionsDisplaymodels: compte.transactions.map((trs) => toTransactionDisplaymodel(trs)).toList(),
          participants: compte.participants,
          currencyCode: compte.currencyCode,
          repartitionParDefaut: compte.repartitionParDefaut,
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
