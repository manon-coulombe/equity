import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';

class CompteDetails extends Equatable {
  final int? id;
  final String nom;
  final TypeDeCompte typeDeCompte;
  final String currencyCode;
  final List<Participant> participants;
  final List<Transaction> transactions;
  final double totalDepenses;
  final Repartition repartitionParDefaut;
  final List<Balance> balance;

  const CompteDetails({
    this.id,
    required this.nom,
    required this.typeDeCompte,
    required this.currencyCode,
    required this.transactions,
    required this.participants,
    required this.totalDepenses,
    required this.repartitionParDefaut,
    this.balance = const [],
  });

  @override
  List<Object?> get props => [
        nom,
        id,
        typeDeCompte,
        currencyCode,
        participants,
        transactions,
        totalDepenses,
        repartitionParDefaut,
        balance,
      ];
}

enum TypeDeCompte {
  COUPLE('Couple', 1),
  COLOCATION('Colocation', 2),
  VOYAGE('Voyage', 3),
  PROJET('Projet', 4);

  final String label;
  final int id;

  const TypeDeCompte(this.label, this.id);
}

enum Repartition {
  EQUITABLE('Équitable', 1),
  EGALE('Égale', 2),
  AUTRE('Personnalisée', 0);

  final String label;
  final int id;

  const Repartition(this.label, this.id);
}

class Balance extends Equatable {
  final String participant;
  final double solde;

  const Balance({required this.participant, required this.solde});

  @override
  List<Object?> get props => [participant, solde];

}
