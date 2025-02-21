import 'package:equity/compte_details/screens/compte_details_displaymodel.dart';
import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionDisplaymodel dm;

  const TransactionDetailsScreen(this.dm, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: Text(dm.titre)),
            body: Text(dm.formattedMontant)));
  }
}
