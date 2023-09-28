import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeet_ke_jeo/src/screens/tutorial/widgets/customcard.widget.dart';
import 'package:velocity_x/velocity_x.dart';

class PlayTutorialScreen extends StatefulWidget {
  const PlayTutorialScreen({Key? key}) : super(key: key);

  @override
  State<PlayTutorialScreen> createState() => _PlayTutorialScreenState();
}

class _PlayTutorialScreenState extends State<PlayTutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return [
      CustomCard(
        num: 1,
        imageUrl: "assets/images/card/login.svg",
        desc: "card-1".tr,
      ),
      CustomCard(
        num: 2,
        imageUrl: "assets/images/card/play.svg",
        desc: "card-2".tr,
      ),
      CustomCard(
        num: 3,
        imageUrl: "assets/images/card/buy.svg",
        desc: "card-3".tr,
      ),
      CustomCard(
        num: 4,
        imageUrl: "assets/images/card/form.svg",
        desc: "card-4".tr,
      ),
      CustomCard(
        num: 5,
        imageUrl: "assets/images/card/pay.svg",
        desc: "card-5".tr,
      ),
      CustomCard(
        num: 6,
        imageUrl: "assets/images/card/prize.svg",
        desc: "card-6".tr,
      ),
    ].column().p16();
  }
}
