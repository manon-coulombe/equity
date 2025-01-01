import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_project/home/redux/home_redux.dart';
import 'package:test_project/home/screen/compte_card.dart';
import 'package:test_project/home/screen/home_viewmodel.dart';
import 'package:test_project/redux/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'EQUITY',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StoreConnector<AppState, HomeViewmodel>(
        converter: (store) => HomeViewmodel.from(store),
        onInit: (store) {
          store.dispatch(FetchComptesAction());
        },
        builder: (context, vm) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              showCurrencyPicker(context: context, onSelect: onSelect),
              SizedBox(height: 48),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(height: 48),
              Expanded(
                child: ListView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: vm.comptes.length,
                    itemBuilder: (context, i) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CompteCard(vm.comptes[i]),
                            SizedBox(height: 24)
                          ]);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}