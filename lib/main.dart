import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spotify_project/core/configs/theme/app_theme.dart';
import 'package:spotify_project/presentation/pages/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';


void main() {
 runApp(
    DevicePreview(
      enabled: true, // Only enable in non-release mode
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
