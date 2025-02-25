import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';

class CompteDetails extends Equatable {
  final int id;
  final String nom;
  final TypeDeCompte typeDeCompte;
  final String currencyCode;
  final List<Participant> participants;
  final List<Transaction> transactions;
  final double totalDepenses;
  final Repartition repartitionParDefaut;

  const CompteDetails({
    required this.id,
    required this.nom,
    required this.typeDeCompte,
    required this.currencyCode,
    required this.transactions,
    required this.participants,
    required this.totalDepenses,
    required this.repartitionParDefaut,
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
      ];
}

enum TypeDeCompte {
  COUPLE,
  COLOCATION,
  VOYAGE,
  PROJET;
}

enum Repartition {
  EQUITABLE('Équitable'),
  EGALE('Égale'),
  AUTRE('Personnalisée');

  final String label;

  const Repartition(this.label);
}
