import 'package:flutter/material.dart';
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
      const CustomCard(
        num: 1,
        imageUrl: "assets/images/card/login.svg",
        desc: "Create an account or log in to your existing account.",
      ),
      const CustomCard(
        num: 2,
        imageUrl: "assets/images/card/play.svg",
        desc: "Click the lottery numbers you would like to play.",
      ),
      const CustomCard(
        num: 3,
        imageUrl: "assets/images/card/buy.svg",
        desc: "Click on Play Button.",
      ),
      const CustomCard(
        num: 4,
        imageUrl: "assets/images/card/form.svg",
        desc: "Fill the Details with address and phone number.",
      ),
      const CustomCard(
        num: 5,
        imageUrl: "assets/images/card/pay.svg",
        desc: "Purchase the lottery",
      ),
      const CustomCard(
        num: 6,
        imageUrl: "assets/images/card/prize.svg",
        desc: "Wait for the results to be announced.",
      ),
    ].column().p16();
  }
}
