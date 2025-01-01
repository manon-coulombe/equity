import 'package:currency_picker/currency_picker.dart';
import 'package:test_project/compte_details/domain/compte_details.dart';
import 'package:test_project/home/domain/compte.dart';
import 'package:test_project/compte_details/domain/participant.dart';
import 'package:test_project/compte_details/domain/transaction.dart';
import 'package:test_project/utils/repo_result.dart';

abstract class IHomeRepository {
  Future<RepoResult<List<Compte>>> getComptes();
}

class HomeRepository extends IHomeRepository {
  @override
  Future<RepoResult<List<Compte>>> getComptes() async {
    final comptes = [
      Compte(nom: 'week-end à Marseille', id: '1'),
      Compte(nom: 'super coloc', id: '2'),
      Compte(nom: '30 ans de Fanny', id: '3'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '4'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '5'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '6'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '7'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '8'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '9'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '10'),
    ];

    return RepoSuccess(comptes);
  }
}
