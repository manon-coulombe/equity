import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BoutonAjouter extends StatelessWidget {
  final void Function() onTap;
  final double size;

  const BoutonAjouter({super.key, required this.onTap, this.size = 68});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icons/plus.svg',
        width: size,
        height: size,
      ),
    );
  }
}
