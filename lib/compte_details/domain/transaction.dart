import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/participant.dart';

abstract class Transaction extends Equatable {
  final int? id;
  final String titre;
  final double montant;
  final String deviseCode;
  final DateTime date;

  const Transaction({
    this.id,
    required this.titre,
    required this.montant,
    required this.deviseCode,
    required this.date,
  });

  @override
  List<Object?> get props => [id, titre, montant, deviseCode, date];
}

class Depense extends Transaction {
  final Participant payeur;
  final Map<Participant, double> repartition;

  const Depense({
    super.id,
    required super.titre,
    required super.montant,
    required super.deviseCode,
    required super.date,
    required this.payeur,
    required this.repartition,
  });
}

class Revenu extends Transaction {
  final Participant receveur;
  final Map<Participant, double> repartition;

  const Revenu({
    super.id,
    required super.titre,
    required super.montant,
    required super.deviseCode,
    required super.date,
    required this.receveur,
    required this.repartition,
  });
}

class Transfert extends Transaction {
  final Participant payeur;
  final Participant receveur;

  const Transfert({
    super.id,
    required super.titre,
    required super.montant,
    required super.deviseCode,
    required super.date,
    required this.payeur,
    required this.receveur,
  });
}
