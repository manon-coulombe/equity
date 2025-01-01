import 'package:equatable/equatable.dart';
import 'package:test_project/compte_details/domain/participant.dart';

abstract class Transaction extends Equatable {
  final String titre;
  final double montant;
  final String deviseCode;
  final DateTime date;

  const Transaction({required this.titre, required this.montant, required this.deviseCode, required this.date});

  @override
  List<Object?> get props => [titre, montant, deviseCode, date];
}

class Depense extends Transaction {
  final Participant payeur;
  final List<Participant> payePour;
  final Map<String, double> repartition;

  const Depense({
    required this.payeur,
    required this.payePour,
    required this.repartition,
    required super.titre,
    required super.montant,
    required super.deviseCode,
    required super.date,
  });
}

class Revenu extends Transaction {
  final Participant receveur;
  final List<Participant> recuPour;
  final Map<String, double> repartition;

  const Revenu({
    required this.receveur,
    required this.recuPour,
    required this.repartition,
    required super.titre,
    required super.montant,
    required super.deviseCode,
    required super.date,
  });
}

class Transfert extends Transaction {
  final Participant payeur;
  final Participant receveur;

  const Transfert({
    required this.payeur,
    required this.receveur,
    required super.titre,
    required super.montant,
    required super.deviseCode,
    required super.date,
  });
}
