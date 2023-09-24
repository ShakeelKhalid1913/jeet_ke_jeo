import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomCard extends StatefulWidget {
  const CustomCard(
      {super.key,
      required this.num,
      required this.imageUrl,
      required this.desc});

  final int num;
  final String imageUrl;
  final String desc;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return [
      [
        '${widget.num}'
            .text
            .color(AppColors.goldColor)
            .xl6
            .make()
            .box
            .roundedFull
            .p12
            .color(AppColors.goldColor.withOpacity(0.2))
            .make(),
        const Spacer(),
        SvgPicture.asset(widget.imageUrl, height: 100, width: 100)
            .box
            .make(),
      ].row(),
      widget.desc.text.make(),
    ].column().p16().card.make().wThreeForth(context);
  }
}
