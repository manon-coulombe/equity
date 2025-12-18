import 'dart:convert' as convert;

import 'package:equity/auth/auth_service.dart';
import 'package:equity/home/domain/compte.dart';
import 'package:equity/utils/repo_result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class IHomeRepository {
  Future<RepoResult<List<Compte>>> getComptes();
}

class HomeRepository extends IHomeRepository {
  final apiUrl = dotenv.env['API_URL'];

  @override
  Future<RepoResult<List<Compte>>> getComptes() async {
    final user = authService.value.currentUser!;
    final idToken = await user.getIdToken();
    final url = Uri.parse('$apiUrl');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "*/*",
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final List<dynamic> data = convert.json.decode(response.body);

      final comptes = data
          .map(
            (e) => Compte(nom: e['nom'], id: e['id']),
          )
          .toList();
      return RepoSuccess(comptes);
    } else {
      return RepoError('Une erreur est survenue');
    }
  }
}
