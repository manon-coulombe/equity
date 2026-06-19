import 'package:equity/compte_details/redux/compte_details_redux.dart';
import 'package:equity/compte_details/screens/compte_details_displaymodel.dart';
import 'package:equity/compte_details/screens/transaction_details/transaction_details_displaymodel.dart';
import 'package:equity/compte_details/screens/transaction_details/transaction_form_screen.dart';
import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionDisplaymodel transactionDisplayModel;
  final CompteDetailsDisplaymodel compteDetailsDisplayModel;

  const TransactionDetailsScreen({
    required this.transactionDisplayModel,
    required this.compteDetailsDisplayModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text('Modifier')),
              PopupMenuItem(value: 1, child: Text('Supprimer')),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Text(
              transactionDisplayModel.titre,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Le ${transactionDisplayModel.formattedDate}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 32, bottom: 8),
              child: Text(
                'Payé par',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Color.fromRGBO(254, 236, 235, 1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transactionDisplayModel.payeur,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      transactionDisplayModel.formattedMontant,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 40, bottom: 8),
              child: Text(
                'Répartition',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            ...transactionDisplayModel.repartition?.entries
                    .map((entries) => RepartitionCard(nom: entries.key, montant: entries.value))
                    .toList() ??
                []
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionForm(compteDetails: compteDetailsDisplayModel)),
        );
      case 1:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Supprimer la transaction', textAlign: TextAlign.center),
            content: const Text(
              'Cette action est irreversible',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Annuler', style: TextStyle(fontSize: 18)),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Color.fromRGBO(252, 99, 97, 1),
                ),
                onPressed: () => DeleteTransactionAction(transactionDisplayModel.id),
                child: const Text('Supprimer', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        );
    }
  }
}

class RepartitionCard extends StatelessWidget {
  final String nom;
  final String montant;

  const RepartitionCard({super.key, required this.nom, required this.montant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Color.fromRGBO(254, 236, 235, 1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                nom,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              Text(
                montant,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
