import 'package:flutter/material.dart';
import 'package:jeet_ke_jeo/src/config/constants/colors.dart';

class Themes {
  static ThemeData theme(context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.goldColor)
          .copyWith(
              secondary: AppColors.goldColor, brightness: Brightness.dark),
      useMaterial3: true,
      primarySwatch: Colors.orange,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 4,
        shadowColor: Theme.of(context).shadowColor,
        titleTextStyle: const TextStyle(
          color: AppColors.goldColor,
          fontWeight: FontWeight.bold,
          fontSize: 35,
        ),
        iconTheme: const IconThemeData(color: AppColors.goldColor),
      ),
    );
  }
}
