import 'package:flutter/material.dart';
import 'package:test_project/home/domaine/compte.dart';

class CompteCard extends StatelessWidget {
  final Compte compte;

  const CompteCard(this.compte, {super.key});

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Color(0xFFE7ECFA), blurRadius: 16)],
        ),
        child: InkWell(
          highlightColor: Color(0xFFE7ECFA),
          splashColor: Color(0xFFE7ECFA),
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              compte.nom,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
