import 'package:equatable/equatable.dart';
import 'package:test_project/compte_details/domain/compte_details.dart';
import 'package:test_project/compte_details/domain/participant.dart';

class CompteDetails extends Equatable {
  final String nom;
  final String id;
  final TypeDeCompte typeDeCompte;
  final List<Participant> participants;

  const CompteDetails({required this.nom, required this.id, required this.participants, required this.typeDeCompte});

  @override
  List<Object?> get props => [nom, id];
}
