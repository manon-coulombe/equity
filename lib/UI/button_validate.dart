import 'package:flutter/material.dart';

class ButtonValidate extends StatelessWidget {
  final void Function() onValidate;
  final bool isLoading;

  const ButtonValidate({required this.onValidate, required this.isLoading, super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onValidate,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
        backgroundColor: Color.fromRGBO(252, 99, 97, 1),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            )
          : Text(
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
