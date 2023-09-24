import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/screens/home/widgets/pinfield.widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:jeet_ke_jeo/src/config/globals/index.dart' as globals;
import 'dart:math';

class NumberGrid extends StatefulWidget {
  const NumberGrid({Key? key}) : super(key: key);

  @override
  State<NumberGrid> createState() => NumberGridState();
}

class NumberGridState extends State<NumberGrid> {
  final List<bool> isSelected = List.generate(49, (index) => false);
  int numberSelected = 0;

  TextEditingController getNextFieldController() {
    int val = numberSelected;
    setState(() {
      numberSelected++;
    });
    return globals.keys[val]
        .currentState!.controller;
  }

  List<Widget> pinFields = [
    PinField(key: globals.keys[0]),
    PinField(key: globals.keys[1]),
    PinField(key: globals.keys[2]),
    PinField(key: globals.keys[3]),
    PinField(key: globals.keys[4]),
    PinField(key: globals.keys[5]),
  ];

  void clearFields() {
    setState(() {
      for (int i = 0; i < 49; i++) {
        isSelected[i] = false;
      }

      numberSelected = 0;
      for (int i = 0; i < 6; i++) {
        globals.keys[i].currentState!.controller.clear();
      }
    });
  }

  void randomGenerator() {
    clearFields();
    List<int> randomNumbers = [];
    Random random = Random();
    while (randomNumbers.length < 6) {
      int randomNumber = random.nextInt(49) + 1;
      if (!randomNumbers.contains(randomNumber)) {
        randomNumbers.add(randomNumber);
      }
    }

    for (int i = 0; i < 6; i++) {
      globals.keys[i].currentState!.controller.text =
          randomNumbers[i].toString();
      setState(() {
        isSelected[randomNumbers[i] - 1] = true;
      });
    }

    setState(() {
      numberSelected = 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return [
      [
        "Pick ${6 - numberSelected} Numbers".text.bold.make(),
        const Spacer(),
        pinFields[0].expand(),
        pinFields[1].expand(),
        pinFields[2].expand(),
        pinFields[3].expand(),
        pinFields[4].expand(),
        pinFields[5].expand(),
        IconButton(
            onPressed: () {
              clearFields();
            },
            icon: const Icon(
              Icons.delete,
              color: AppColors.redColor,
            )).expand()
      ].row().p2().box.white.rounded.make().wFull(context),
      ElevatedButton(
        onPressed: () {
          randomGenerator();
        },
        child: ["Random".text.xl4.make(), const Icon(Icons.shuffle)]
            .row(alignment: MainAxisAlignment.center)
            .wFull(context),
      ).p4(),
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        itemCount: 49,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
                  onTap: () {
                    if (numberSelected == 6) {
                      return;
                    }
                    if (isSelected[index] == true) {
                      return;
                    }
                    setState(() {
                      getNextFieldController().text = (index + 1).toString();
                      isSelected[index] = !isSelected[index];
                    });
                  },
                  child: "${index + 1}"
                      .text
                      .size(16)
                      .makeCentered()
                      .p4()
                      .box
                      .roundedFull
                      .color(isSelected[index]
                          ? AppColors.goldColor
                          : Colors.white)
                      .make())
              .p4();
        },
      ).box.height(380).p3.make()
    ].column();
  }
}
