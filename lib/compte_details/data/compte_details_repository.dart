import 'package:test_project/compte_details/domain/compte_details.dart';
import 'package:test_project/compte_details/domain/participant.dart';
import 'package:test_project/compte_details/domain/transaction.dart';
import 'package:test_project/utils/repo_result.dart';

abstract class ICompteDetailsRepository {
  Future<RepoResult<CompteDetails>> getCompteDetails(String compteId);
}

class CompteDetailsRepository extends ICompteDetailsRepository {
  @override
  Future<RepoResult<CompteDetails>> getCompteDetails(String compteId) async {
    final participant1 = Participant(id: '1', nom: 'Jean', revenus: 2500);
    final participant2 = Participant(id: '2', nom: 'Jeanne', revenus: 3450);
    final participant3 = Participant(id: '3', nom: 'Albus', revenus: 13456);

    final detailsCompte = CompteDetails(
      id: '1',
      nom: 'week-end à Marseille',
      typeDeCompte: TypeDeCompte.VOYAGE,
      deviseCode: 'EUR',
      transactions: [
        Depense(
          payeur: participant1,
          payePour: [participant3, participant2, participant1],
          repartition: {'1': 125, '2': 125, '3': 125},
          titre: 'Logement',
          montant: 375,
          deviseCode: 'EUR',
          date: DateTime(2024, 9, 12),
          id: '1',
        ),
        Depense(
          payeur: participant2,
          payePour: [participant3, participant2, participant1],
          repartition: {'1': 39, '2': 39, '3': 39},
          titre: 'Restaurant tapas',
          montant: 117,
          deviseCode: 'EUR',
          date: DateTime(2024, 9, 18),
          id: '2',
        ),
        Depense(
          payeur: participant3,
          payePour: [participant3, participant2, participant1],
          repartition: {'1': 77.22, '2': 77.22, '3': 77.22},
          titre: 'billets de train',
          montant: 231.66,
          deviseCode: 'EUR',
          date: DateTime(2024, 9, 10),
          id: '3',
        ),
      ],
      participants: [participant1, participant2, participant3],
      totalDepenses: 723.66,
    );

    return RepoSuccess(detailsCompte);
  }
}
