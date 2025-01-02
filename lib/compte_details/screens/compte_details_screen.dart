import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_project/UI/bouton_ajouter.dart';
import 'package:test_project/compte_details/screens/compte_details_viewmodel.dart';
import 'package:test_project/compte_details/screens/transaction_item.dart';
import 'package:test_project/redux/app_state.dart';
import 'package:test_project/utils/status.dart';

class CompteDetailsScreen extends StatelessWidget {
  final String id;

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
              backgroundColor: Theme.of(context).colorScheme.primary,
              title: Text(vm.compteDetails?.titre ?? ''),
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
    final transactionsDisplaymodels = vm.compteDetails!.transactionsDisplaymodels;

    return Column(
      children: [
        SizedBox(height: 48),
        BoutonAjouter(onTap: () {}),
        SizedBox(height: 48),
        Expanded(
          child: ListView.separated(
            controller: controller,
            shrinkWrap: true,
            itemCount: transactionsDisplaymodels.length,
            itemBuilder: (context, i) {
              return TransactionItem(transactionsDisplaymodels[i]);
            },
            separatorBuilder: (_, __) => Divider(color: Colors.black),
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
