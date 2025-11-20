import 'package:equity/UI/bouton_add.dart';
import 'package:equity/compte_details/screens/compte_details_viewmodel.dart';
import 'package:equity/compte_details/screens/transaction_details/transaction_form.dart';
import 'package:equity/compte_details/screens/transaction_item.dart';
import 'package:equity/redux/app_state.dart';
import 'package:equity/utils/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CompteDetailsScreen extends StatefulWidget {
  final int id;

  const CompteDetailsScreen(this.id, {super.key});

  @override
  State<CompteDetailsScreen> createState() => _CompteDetailsScreenState();
}

class _CompteDetailsScreenState extends State<CompteDetailsScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompteDetailsViewmodel>(
      distinct: true,
      converter: (store) => CompteDetailsViewmodel.from(store, compteId: widget.id),
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
            bottom: TabBar(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: 'Transactions'),
                Tab(text: 'Répartition'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              Center(child: TransactionsTab(vm: vm)),
              Center(child: RepartitionTab(vm: vm)),
            ],
          ),
        );
      },
    );
  }
}

class TransactionsTab extends StatelessWidget {
  final CompteDetailsViewmodel vm;

  const TransactionsTab({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return switch (vm.status) {
      Status.LOADING => Loading(),
      Status.ERROR || Status.NOT_LOADED => Error(),
      Status.SUCCESS => vm.compteDetails != null ? TransactionsTabSuccess(vm) : Error(),
    };
  }
}

class RepartitionTab extends StatelessWidget {
  final CompteDetailsViewmodel vm;

  const RepartitionTab({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return switch (vm.status) {
      Status.LOADING => Loading(),
      Status.ERROR || Status.NOT_LOADED => Error(),
      Status.SUCCESS => vm.compteDetails != null ? RepartitionTabSuccess(vm: vm) : Error(),
    };
  }
}

class RepartitionTabSuccess extends StatelessWidget {
  final CompteDetailsViewmodel vm;

  const RepartitionTabSuccess({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...vm.compteDetails!.balance.map((b) => Row(
              children: [
                Text(b.participant),
                Text(b.solde.toString()),
              ],
            )),
      ],
    );
  }
}

class TransactionsTabSuccess extends StatelessWidget {
  const TransactionsTabSuccess(this.vm, {super.key});

  final CompteDetailsViewmodel vm;

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    final compteDetails = vm.compteDetails!;
    final transactionsDisplaymodels = compteDetails.transactionsDisplaymodels;

    return Column(
      children: [
        SizedBox(height: 40),
        BoutonAdd(onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransactionForm(compteDetails: compteDetails)),
          );
        }),
        SizedBox(height: 32),
        Expanded(
          child: transactionsDisplaymodels.isNotEmpty
              ? ListView.builder(
                  controller: controller,
                  shrinkWrap: true,
                  itemCount: transactionsDisplaymodels.length,
                  itemBuilder: (_, i) {
                    return TransactionItem(transactionsDisplaymodels[i]);
                  },
                )
              : Text('Pas encore de transactions', style: TextStyle(fontSize: 20)),
        ),
        SizedBox(height: 16),
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
    return Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: CircularProgressIndicator(color: Color.fromRGBO(106, 208, 153, 1), strokeWidth: 6),
      ),
    );
  }
}
