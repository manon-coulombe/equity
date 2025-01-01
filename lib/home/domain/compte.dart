import 'package:equatable/equatable.dart';

class Compte extends Equatable {
  final String id;
  final String nom;

  const Compte({required this.nom, required this.id});

  @override
  List<Object?> get props => [nom, id];
}

