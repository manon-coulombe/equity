import 'package:flutter/material.dart';

class TypeDeCompteCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function() select;

  const TypeDeCompteCard({
    required this.label,
    required this.isSelected,
    required this.select,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: select,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Color(0xFFE7ECFA), blurRadius: 16)],
          border: isSelected ? Border.all(color: Color.fromRGBO(106, 208, 153, 1), width: 2) : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(label, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
