import 'package:flutter/material.dart';

class ButtonValidate extends StatelessWidget {
  final void Function() onValidate;
  const ButtonValidate({required this.onValidate, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onValidate,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        backgroundColor: Color.fromRGBO(252, 99, 97, 1),
      ),
      child: const Text(
        'Valider',
        style: TextStyle(
          fontSize: 22,
          color: Color.fromRGBO(253, 221, 219, 1),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
