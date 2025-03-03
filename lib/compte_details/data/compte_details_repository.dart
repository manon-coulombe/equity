import 'dart:convert' as convert;

import 'package:equity/compte_details/data/compte_details_repository_mapper.dart';
import 'package:equity/compte_details/domain/compte_details.dart';
import 'package:equity/compte_details/domain/participant.dart';
import 'package:equity/compte_details/domain/transaction.dart';
import 'package:equity/utils/repo_result.dart' show RepoError, RepoResult, RepoSuccess;
import 'package:http/http.dart' as http;

abstract class ICompteDetailsRepository {
  Future<RepoResult<CompteDetails>> getCompteDetails(int compteId);

  Future<RepoResult<void>> postTransaction(Transaction transaction, int compteId);

  Future<RepoResult<void>> postParticipant(Participant participant, int compteId);
}

class CompteDetailsRepository extends ICompteDetailsRepository {
  @override
  Future<RepoResult<CompteDetails>> getCompteDetails(int compteId) async {
    final url = Uri.parse('https://equity-api.onrender.com/compte/$compteId');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "Accept": "*/*"},
    );

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final Map<String, dynamic> data = convert.json.decode(response.body);
      return RepoSuccess(data.toCompteDetails());
    } else {
      return RepoError('Une erreur est survenue');
    }
  }

  @override
  Future<RepoResult<void>> postTransaction(Transaction transaction, int compteId) async {
    final url = Uri.parse('https://equity-api.onrender.com/transaction');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json", "Accept": "*/*"},
      body: convert.jsonEncode(transaction.toTransactionJson(compteId)),
    );

    if (response.statusCode == 201) {
      return RepoSuccess(null);
    } else {
      return RepoError('Une erreur est survenue');
    }
  }

  @override
  Future<RepoResult<void>> postParticipant(Participant participant, int compteId) async {
    final url = Uri.parse('https://equity-api.onrender.com/participant');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json", "Accept": "*/*"},
      body: convert.jsonEncode(participant.toParticipantJson(compteId)),
    );

    if (response.statusCode == 201) {
      return RepoSuccess(null);
    } else {
      return RepoError('Une erreur est survenue');
    }
  }
}
