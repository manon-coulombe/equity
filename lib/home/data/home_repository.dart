import 'package:test_project/home/domaine/compte.dart';
import 'package:test_project/utils/repo_result.dart';

abstract class IHomeRepository {
  Future<RepoResult<List<Compte>>> getComptes();
}

class HomeRepository extends IHomeRepository {
  @override
  Future<RepoResult<List<Compte>>> getComptes() async {
    final comptes = [
      Compte(nom: 'week-end à Marseille', id: '1'),
      Compte(nom: 'super coloc', id: '1'),
      Compte(nom: '30 ans de Fanny', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
      Compte(nom: 'Lorem ipsum dolor sit amet.', id: '1'),
    ];

    return RepoSuccess(comptes);
  }
}
