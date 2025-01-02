import 'package:flutter/material.dart';
import 'package:test_project/compte_details/screens/compte_details_displaymodel.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionDisplaymodel dm;

  const TransactionDetailsScreen(this.dm, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Text(dm.titre)));
  }
}
