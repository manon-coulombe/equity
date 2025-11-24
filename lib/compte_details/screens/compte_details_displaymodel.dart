import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/screens/transaction_details/transaction_details_displaymodel.dart';

class CompteDetailsDisplaymodel extends Equatable {
  final int id;
  final String titre;
  final String formattedTotal;
  final String formattedBalance;
  final List<TransactionDisplaymodel> transactionsDisplaymodels;
  final List<Participant> participants;
  final String currencyCode;
  final Repartition repartitionParDefaut;
  final List<BalanceDisplayModel> balance;

  const CompteDetailsDisplaymodel({
    required this.id,
    required this.titre,
    required this.formattedTotal,
    required this.formattedBalance,
    required this.transactionsDisplaymodels,
    required this.participants,
    required this.currencyCode,
    required this.repartitionParDefaut,
    required this.balance,
  });

  @override
  List<Object?> get props => [
        id,
        titre,
        formattedTotal,
        formattedBalance,
        transactionsDisplaymodels,
        participants,
        balance,
      ];
}

CompteDetailsDisplaymodel? toCompteDetailsDisplaymodel(CompteDetails? compte) {
  return compte == null
      ? null
      : CompteDetailsDisplaymodel(
          id: compte.id!,
          titre: compte.nom,
          formattedTotal: '${compte.totalDepenses} ${compte.currency.symbol}'.replaceAll('.', ','),
          formattedBalance: 'formattedBalance',
          transactionsDisplaymodels: compte.transactions.map((trs) => toTransactionDisplaymodel(trs)).toList(),
          participants: compte.participants,
          currencyCode: compte.currency.symbol,
          repartitionParDefaut: compte.repartitionParDefaut,
          balance: compte.balance.map(
                (b) => BalanceDisplayModel(
                  participant: b.participant,
                  formattedSolde: '${b.solde} ${compte.currency.symbol}'.replaceAll('.', ','),
                ),
              ).toList(),
        );
}

class BalanceDisplayModel extends Equatable {
  final String participant;
  final String formattedSolde;

  const BalanceDisplayModel({required this.participant, required this.formattedSolde});

  @override
  List<Object?> get props => [participant, formattedSolde];
}
