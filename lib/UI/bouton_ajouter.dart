import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BoutonAjouter extends StatelessWidget {
  final void Function() onTap;

  const BoutonAjouter({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/plus.svg',
        width: 80,
        height: 80,
      ),
    );
  }
}
