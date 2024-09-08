import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_project/core/configs/theme/app_theme.dart';
import 'package:spotify_project/firebase_options.dart';
import 'package:spotify_project/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:spotify_project/presentation/pages/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/presentation/home/pages/home.dart';
import 'package:spotify_project/service_locator.dart';

Future<void> main() async {
  // Ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Get current authenticated user (if any)
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  // Initialize HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // Initialize other dependencies (e.g., service locators)
  await initializeDependencies();

  // Run the app with DevicePreview (enabled only for debugging purposes)
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,  // Disable DevicePreview in release mode
      builder: (context) => MyApp(isLoggedIn: user != null),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            locale: DevicePreview.locale(context),  // Locales for preview
            builder: DevicePreview.appBuilder,      // Wraps for DevicePreview
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,             // Light theme config
            darkTheme: AppTheme.darkTheme,          // Dark theme config
            themeMode: themeMode,                   // Current theme mode
            home: isLoggedIn ?  const Root() : const SplashScreen(),  // Navigate based on login
          );
        },
      ),
    );
  }
}
