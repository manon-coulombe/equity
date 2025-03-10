import 'package:equatable/equatable.dart';

class Participant extends Equatable {
  final int? id;
  final String nom;
  final double revenus;

  const Participant({this.id, required this.nom, required this.revenus});

  @override
  List<Object?> get props => [nom, revenus];
}
