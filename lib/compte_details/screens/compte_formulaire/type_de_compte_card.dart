import 'package:flutter/material.dart';

class TypeDeCompteCard extends StatelessWidget {
  final String label;
  const TypeDeCompteCard({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Color(0xFFE7ECFA), blurRadius: 16)],
      ),
      child: InkWell(
        highlightColor: Color(0xFFE7ECFA),
        splashColor: Color(0xFFE7ECFA),
        onTap: () {
          //select
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(label, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
