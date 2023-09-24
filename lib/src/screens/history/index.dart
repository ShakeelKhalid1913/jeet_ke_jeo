import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/screens/history/widgets/historytable.widget.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Accordion(
      headerPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      headerBorderColor: Colors.blueGrey,
      headerBorderColorOpened: Colors.transparent,
      headerBorderWidth: 1,
      headerBackgroundColorOpened: AppColors.goldColor,
      contentBackgroundColor: Colors.white,
      contentBorderColor: AppColors.goldColor,
      contentBorderWidth: 3,
      contentHorizontalPadding: 20,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      children: [
        section(context, "Lottery 10/12/2023", const HistoryTable()),
        section(context, "Lottery 10/12/2023", const HistoryTable()),
        section(context, "Lottery 10/12/2023", const HistoryTable()),
      ],
    );
  }

  AccordionSection section(
      BuildContext context, String header, HistoryTable data) {
    return AccordionSection(
        isOpen: true,
        contentVerticalPadding: 20,
        leftIcon: const Icon(Icons.text_fields_rounded, color: Colors.white),
        header:
            header.text.color(AppColors.blackColor).minFontSize(18).bold.make(),
        content: data,
        rightIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black54,
          size: 30,
        ));
  }
}
