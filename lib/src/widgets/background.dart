import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';

class BackGround extends StatelessWidget {
  final Widget Function() body;

  const BackGround({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.9],
            colors: [
              Colors.black,
              AppColors.goldColor,
            ],
          ),
        ),
        child: Container(color: Colors.transparent, child: body()));
  }
}
