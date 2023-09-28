import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/firebase_options.dart';
import 'package:jeet_ke_jeo/src/config/constants/theme.dart';
import 'package:jeet_ke_jeo/src/utils/routes.dart';
import 'package:jeet_ke_jeo/src/utils/translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslation(),
      locale: const Locale('en', 'US'),
      title: 'Jeet Ke Jeo',
      debugShowCheckedModeBanner: false,
      theme: Themes.theme(context),
      themeMode: ThemeMode.dark,
      darkTheme: Themes.theme(context),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
