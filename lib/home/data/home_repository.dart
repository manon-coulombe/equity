import 'dart:convert' as convert;

import 'package:equity/home/domain/compte.dart';
import 'package:equity/utils/repo_result.dart';
import 'package:http/http.dart' as http;

abstract class IHomeRepository {
  Future<RepoResult<List<Compte>>> getComptes();
}

class HomeRepository extends IHomeRepository {
  @override
  Future<RepoResult<List<Compte>>> getComptes() async {
    final url = Uri.parse('http://192.168.1.30:3000/');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Accept": "*/*"},
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final List<dynamic> data = convert.json.decode(response.body);
      print('data: $data');

      final comptes = data
          .map(
            (e) => Compte(nom: e['nom'], id: e['id']),
          )
          .toList();
      print('comptes: $comptes');
      return RepoSuccess(comptes);
    } else {
      return RepoError('Une erreur est survenue');
    }
  }
}
