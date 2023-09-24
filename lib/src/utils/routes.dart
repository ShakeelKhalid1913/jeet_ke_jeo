import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/splash.dart';
import 'package:jeet_ke_jeo/src/screens/auth/login/index.dart';
import 'package:jeet_ke_jeo/src/screens/auth/signup/index.dart';
import 'package:jeet_ke_jeo/src/screens/home/index.dart';
import 'package:jeet_ke_jeo/src/screens/purchase/index.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/purchase':
        return MaterialPageRoute(builder: (context) => PurchaseLottery(lotteryData: args));
      default: return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(title: const Text("ERROR"), centerTitle: true,),
        body: const Center(child: Text("Page Not Found!"),),
      );
    });
  }
}