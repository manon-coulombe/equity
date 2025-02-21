import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';

extension CompteDetailsRepositoryMapper on Map<String, dynamic> {
  CompteDetails toCompteDetails() {
    final typeDeCompte = _getTypeDeCompte(this['type']?['nom']);
    final transactions = _getTransactions(this['transactions']);
    final participants = _getParticipants(this['participants']);

    return CompteDetails(
      id: this['id'],
      nom: this['nom'],
      typeDeCompte: typeDeCompte,
      deviseCode: this['devise'],
      transactions: transactions,
      participants: participants,
      totalDepenses: 0,
    );
  }

  TypeDeCompte _getTypeDeCompte(String? type) {
    return switch (type) {
      'COUPLE' => TypeDeCompte.COUPLE,
      'COLOCATION' => TypeDeCompte.COLOCATION,
      'VOYAGE' => TypeDeCompte.VOYAGE,
      _ => TypeDeCompte.PROJET,
    };
  }

  List<Transaction> _getTransactions(List<dynamic> transactionsMap) {
    return transactionsMap
        .map((map) {
          final type = map['type']['nom'] as String;
          final id = map['id'];
          final nom = map['nom'];
          final montant = double.parse(map['montant']);
          final deviseCode = map['devise'];
          final date = DateTime.parse(map['date']);
          final payeur = Participant(
            id: map['payeur']['id'],
            nom: map['payeur']['nom'],
            revenus: double.parse(map['payeur']['revenus']),
          );

          return switch (type) {
            "DEPENSE" => Depense(
                id: id,
                titre: nom,
                montant: montant,
                deviseCode: deviseCode,
                date: date,
                payeur: payeur,
                repartition: _getRepartition(map['repartitions']),
              ),
            "REVENU" => Revenu(
                id: id,
                titre: nom,
                montant: montant,
                deviseCode: deviseCode,
                date: date,
                receveur: payeur,
                repartition: _getRepartition(map['repartitions']),
              ),
            "TRANSFERT" => Transfert(
                id: map['id'],
                titre: map['nom'],
                montant: montant,
                deviseCode: deviseCode,
                date: date,
                payeur: payeur,
                receveur: _getReceveur(map['repartitions'], payeur.id),
              ),
            _ => null,
          };
        })
        .nonNulls
        .toList();
  }

  Map<Participant, double> _getRepartition(List<dynamic> repartitionsMap) {
    return {
      for (var repartition in repartitionsMap)
        Participant(
          id: repartition['participant']['id'],
          nom: repartition['participant']['nom'],
          revenus: double.parse(repartition['participant']['revenus']),
        ): double.parse(repartition['montant'])
    };
  }

  Participant _getReceveur(List<dynamic> repartitionsMap, int payeurId) {
    final receveur = repartitionsMap.firstWhere(
      (repartiton) => repartiton['participant']['id'] != payeurId,
    );
    return Participant(
      id: receveur['id'],
      nom: receveur['nom'],
      revenus: double.parse(receveur['revenus']),
    );
  }

  List<Participant> _getParticipants(List<dynamic> participantsMap) {
    return participantsMap
        .map((participant) => Participant(
              id: participant['id'],
              nom: participant['nom'],
              revenus: double.parse(participant['revenus']),
            ))
        .toList();
  }
}
