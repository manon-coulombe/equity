import 'package:equity/compte_details/screens/compte_details_screen.dart';
import 'package:equity/home/domain/compte.dart';
import 'package:flutter/material.dart';

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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompteDetailsScreen(compte.id)),
            );
          },
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
