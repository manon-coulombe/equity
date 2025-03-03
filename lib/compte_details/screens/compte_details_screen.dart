import 'package:equity/UI/bouton_ajouter.dart';
import 'package:equity/compte_details/screens/compte_details_viewmodel.dart';
import 'package:equity/compte_details/screens/transaction_details/transaction_form.dart';
import 'package:equity/compte_details/screens/transaction_item.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CompteDetailsScreen extends StatelessWidget {
  final int id;

  const CompteDetailsScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompteDetailsViewmodel>(
      distinct: true,
      converter: (store) => CompteDetailsViewmodel.from(store, compteId: id),
      onInitialBuild: (vm) {
        vm.fetchCompte();
      },
      builder: (context, vm) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(253, 221, 219, 1),
              title: Text(
                vm.compteDetails?.titre ?? '',
                style: TextStyle(color: Color.fromRGBO(254, 99, 101, 1), fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
            ),
            body: switch (vm.status) {
              Status.LOADING => Loading(),
              Status.ERROR || Status.NOT_LOADED => Error(),
              Status.SUCCESS => vm.compteDetails != null ? Success(vm) : Error(),
            });
      },
    );
  }
}

class Success extends StatelessWidget {
  const Success(this.vm, {super.key});

  final CompteDetailsViewmodel vm;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final compteDetails = vm.compteDetails!;
    final transactionsDisplaymodels = compteDetails.transactionsDisplaymodels;

    return Column(
      children: [
        SizedBox(height: 32),
        BoutonAjouter(onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionForm(compteDetails: compteDetails)),
          );
        }),
        SizedBox(height: 32),
        Divider(color: Colors.black),
        Expanded(
          child: ListView.builder(
            controller: controller,
            shrinkWrap: true,
            itemCount: transactionsDisplaymodels.length,
            itemBuilder: (_, i) {
              return Column(
                children: [
                  TransactionItem(transactionsDisplaymodels[i]),
                  Divider(color: Colors.black),
                ],
              );
            },
          ),
        ),
        Container(
          color: Color.fromRGBO(106, 208, 153, 1),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total dépenses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(vm.compteDetails!.formattedTotal),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Ma balance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(vm.compteDetails!.formattedBalance),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('error');
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('Loading');
  }
}
