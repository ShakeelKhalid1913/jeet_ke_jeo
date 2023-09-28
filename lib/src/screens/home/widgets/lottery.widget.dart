import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/screens/home/widgets/numbergrid.widget.dart';
import 'package:jeet_ke_jeo/src/services/firebase/collections/user.collection.dart';
import 'package:jeet_ke_jeo/src/widgets/background.dart';
import 'package:jeet_ke_jeo/src/widgets/dialogbox.widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:jeet_ke_jeo/src/config/globals/index.dart' as globals;

class Lottery extends StatefulWidget {
  const Lottery({super.key});

  @override
  State<Lottery> createState() => _LotteryState();
}

class _LotteryState extends State<Lottery> {
  final FirebaseUserCollection _userCollection = FirebaseUserCollection();
  int numberOfUsers = 0;

  @override
  void initState() {
    _userCollection.getNumberOfUsers().then((value) {
      setState(() {
        numberOfUsers = value;
      });
    });
    super.initState();
  }

  final List<Widget> _children = [
    [
      Image.asset(
        'assets/images/prizes/cg125-red-01.png',
        fit: BoxFit.cover,
      ).p4().box.white.withRounded(value: 15).make(),
      "Honda 125cc".text.xl2.make().p4(),
    ].stack(),
    [
      Image.asset(
        'assets/images/prizes/Honda-cd-70-2.png',
        fit: BoxFit.cover,
      ).p4().box.white.withRounded(value: 15).make(),
      "Honda cd70".text.xl2.make().p4(),
    ].stack(),
    [
      Image.asset(
        'assets/images/prizes/umrah.png',
        fit: BoxFit.cover,
      ).p4().box.white.withRounded(value: 15).make(),
      "Umrah Ticket".text.xl2.make().p4(),
    ].stack(),
    [
      Image.asset(
        'assets/images/prizes/dubai.png',
        fit: BoxFit.cover,
      ).p4().box.white.withRounded(value: 15).make(),
      "Dubai Ticket".text.xl2.make().p4(),
    ].stack()
  ];

  @override
  Widget build(BuildContext context) {
    return [BackGround(body: _body)].column();
  }

  Widget _body() {
    return [
      "Current number of Users $numberOfUsers"
          .text
          .xl2
          .makeCentered()
          .box
          .roundedLg
          .white
          .make(),
      _children
          .map((e) => e)
          .toList()
          .swiper(
              height: context.isMobile ? 200 : 400,
              enlargeCenterPage: true,
              autoPlay: true,
              isFastScrollingEnabled: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
              scrollDirection:
                  context.isMobile ? Axis.horizontal : Axis.horizontal)
          .p16(),
      NumberGrid(key: globals.numberGridKey),
      ElevatedButton(
        onPressed: () {
          if (globals.numberGridKey.currentState!.numberSelected != 6) {
            CustomDialog.dialog(context, "Error", "Please select 6 numbers");
            return;
          }
          String text = "";
          for (int i = 0; i < 6; i++) {
            text += "${globals.keys[i].currentState!.controller.text}-";
          }
          text = text.substring(0, text.length - 1);
          Navigator.pushNamed(context, "/purchase",
              arguments: {"lotteryNumber": text});
        },
        child: "play".tr.text.xl4.make(),
      ).wFull(context).h(50).p16(),
    ].column().p16();
  }
}
