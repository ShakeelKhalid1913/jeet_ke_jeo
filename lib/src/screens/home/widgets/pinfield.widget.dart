import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class PinField extends StatefulWidget {
  final TextEditingController controller = TextEditingController();
  PinField({super.key});

  @override
  State<PinField> createState() => PinFieldState();
}

class PinFieldState extends State<PinField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
            textAlign: TextAlign.center,
            controller: controller,
            decoration: const InputDecoration(enabled: false),
            style: const TextStyle(
                color: AppColors.blackColor, fontWeight: FontWeight.bold))
        .box
        .width(30)
        .make()
        .p4();
  }
}
