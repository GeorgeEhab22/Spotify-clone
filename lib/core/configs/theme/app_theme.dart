import 'package:flutter/material.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: 'Satoshi',
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));
  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      fontFamily: 'Satoshi',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary,
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)))));
}
