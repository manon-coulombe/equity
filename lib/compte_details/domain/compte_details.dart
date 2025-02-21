import 'package:equatable/equatable.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';

class CompteDetails extends Equatable {
  final int id;
  final String nom;
  final TypeDeCompte typeDeCompte;
  final String deviseCode;
  final List<Participant> participants;
  final List<Transaction> transactions;
  final double totalDepenses;

  const CompteDetails({
    required this.id,
    required this.nom,
    required this.typeDeCompte,
    required this.deviseCode,
    required this.transactions,
    required this.participants,
    required this.totalDepenses,
  });

  @override
  List<Object?> get props => [
        nom,
        id,
        typeDeCompte,
        deviseCode,
        participants,
        transactions,
        totalDepenses
      ];
}

enum TypeDeCompte {
  COUPLE,
  COLOCATION,
  VOYAGE,
  PROJET;
}
