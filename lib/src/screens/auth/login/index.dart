import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';
import 'package:jeet_ke_jeo/src/services/firebase/auth.dart';
import 'package:jeet_ke_jeo/src/widgets/dialogbox.widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final _formKey = GlobalKey<FormState>();
  bool _loaded = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    String email = emailController.text;
    String password = passwordController.text;
    setState(() {
      _loaded = true;
    });

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    setState(() {
      _loaded = false;
    });

    if (user != null) {
      if (context.mounted) {
        Navigator.pushNamed(context, '/home');
      }
    } else {
      if (context.mounted) {
        CustomDialog.dialog(context, "Sign In Failed",
            "Please check your email and password and try again.");
      }
    }
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
          body: [
            Opacity(
                opacity: _loaded ? 0.5 : 1,
                child: AbsorbPointer(absorbing: _loaded, child: _body())),
            Opacity(
                opacity: _loaded ? 1 : 0,
                child: const Center(child: CircularProgressIndicator(color: AppColors.whiteColor,)))
          ].stack()),
    );
  }

  Widget _body() {
    return Form(
        key: _formKey,
        child: [
          "Welcome\nBack"
              .text
              .color(Colors.white)
              .xl6
              .make()
              .box
              .padding(const EdgeInsets.only(left: 35, top: 130))
              .make(),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter valid email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                prefixIcon: const Icon(
                  Icons.password,
                  color: AppColors.blackColor,
                )),
            const SizedBox(height: 40),
            [
              "Sign in".text.xl4.fontWeight(FontWeight.bold).make(),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black54,
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      } else {
                        CustomDialog.dialog(context, "Sign In Failed",
                            "Please check your email and password and try again.");
                      }
                    },
                    icon: const Icon(Icons.arrow_forward)),
              )
            ].row(alignment: MainAxisAlignment.spaceBetween),
            const SizedBox(height: 40),
            const Divider(color: Colors.black),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              style: const ButtonStyle(),
              child: "Go to Sign Up"
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
                  top: MediaQuery.of(context).size.height * 0.5))
              .margin(const EdgeInsets.only(left: 35, right: 35))
              .make()
              .scrollVertical()
        ].stack());
  }
}
