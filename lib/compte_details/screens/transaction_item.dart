import 'package:flutter/material.dart';
import 'package:test_project/compte_details/screens/compte_details_displaymodel.dart';
import 'package:test_project/compte_details/screens/transaction_details/transaction_details_screen.dart';

class TransactionItem extends StatelessWidget {
  final TransactionDisplaymodel transaction;

  const TransactionItem(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Color(0xFFE7ECFA),
      splashColor: Color(0xFFE7ECFA),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionDetailsScreen(transaction)),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  transaction.titre,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  transaction.formattedDate,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            Text(transaction.formattedMontant),
          ],
        ),
      ),
    );
  }
}
