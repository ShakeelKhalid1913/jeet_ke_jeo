import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/services/firebase/auth.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 100),
              child: "Create\nAccount".text.white.xl6.make(),
            ),
            [
              VxTextField(
                keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  style: const TextStyle(color: AppColors.blackColor),
                  hint: "Email",
                  hintStyle: const TextStyle(color: AppColors.blackColor),
                  fillColor: Colors.grey.shade100,
                  borderRadius: 10,
                  borderType: VxTextFieldBorderType.roundLine,
                  prefixIcon: const Icon(
                    Icons.email,
                    color: AppColors.blackColor,
                  )),
              const SizedBox(height: 20),
              VxTextField(
                  controller: passwordController,
                  style: const TextStyle(color: AppColors.blackColor),
                  hint: "Password",
                  hintStyle: const TextStyle(color: AppColors.blackColor),
                  fillColor: Colors.grey.shade100,
                  borderRadius: 10,
                  borderType: VxTextFieldBorderType.roundLine,
                  isPassword: true,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  prefixIcon: const Icon(
                    Icons.password,
                    color: AppColors.blackColor,
                  )),
              const SizedBox(height: 40),
              [
                "Sign up".text.xl4.fontWeight(FontWeight.bold).make(),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: _signUp,
                    icon: const Icon(
                      Icons.arrow_forward,
                    ),
                  ),
                )
              ].row(alignment: MainAxisAlignment.spaceBetween),
              const SizedBox(height: 40),
              const Divider(color: Colors.black),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: "Go to Sign In"
                    .text
                    .align(TextAlign.left)
                    .color(const Color(0xff4c505b))
                    .underline
                    .xl
                    .make(),
              ).box.alignCenter.make()
            ]
                .column()
                .box
                .padding(EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4))
                .margin(const EdgeInsets.only(left: 35, right: 35))
                .make()
                .scrollVertical()
          ].stack()),
    );
  }

  void _signUp() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      Navigator.pushNamed(context, '/home');
    } else {
      debugPrint("Sign up failed");
    }
  }
}
