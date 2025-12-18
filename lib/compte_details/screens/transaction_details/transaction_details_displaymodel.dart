import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/transaction.dart';
import 'package:intl/intl.dart';

class TransactionDisplaymodel extends Equatable {
  final int? id;
  final String titre;
  final String formattedDate;
  final String formattedMontant;
  final String payeur;
  final Map<String, String>? repartition;

  const TransactionDisplaymodel({
    this.id,
    required this.titre,
    required this.formattedDate,
    required this.formattedMontant,
    required this.payeur,
    this.repartition,
  });

  @override
  List<Object?> get props => [id, titre, formattedDate, formattedMontant, payeur, repartition];
}

TransactionDisplaymodel toTransactionDisplaymodel(Transaction transaction) {
  return TransactionDisplaymodel(
    id: transaction.id,
    titre: transaction.titre,
    formattedDate: DateFormat('dd MMM yyyy').format(transaction.date),
    formattedMontant: '${transaction.montant.toStringAsFixed(2)} ${transaction.currency.symbol}'.replaceAll('.', ','),
    payeur: transaction is Depense ? transaction.payeur.nom : 'todo',
    repartition: transaction is Depense
        ? transaction.repartition.map((p, m) => MapEntry(p.nom, '${m.toString()} ${transaction.currency.symbol}'.replaceAll('.', ',')))
        : null,
  );
}
