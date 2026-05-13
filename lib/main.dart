import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/title_screen.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
  runApp(const SushiorApp());
}

class SushiorApp extends StatelessWidget {
  const SushiorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sushior',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffold,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.header,
          brightness: Brightness.light,
          surface: AppColors.scaffold,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffold,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: AppColors.header,
          contentTextStyle: TextStyle(color: AppColors.onHeader),
        ),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
      ),
      home: const TitleScreen(),
    );
  }
}