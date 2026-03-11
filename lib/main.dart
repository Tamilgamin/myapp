import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ar_chemistry_lab/screens/home_screen.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';
import 'package:ar_chemistry_lab/services/ai_service.dart';
import 'package:ar_chemistry_lab/services/ar_service.dart';
import 'package:ar_chemistry_lab/services/experiment_service.dart';
import 'package:ar_chemistry_lab/services/audio_vibration_service.dart';
import 'package:ar_chemistry_lab/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        Provider(create: (_) => AIService()),
        Provider(create: (_) => ARService()),
        Provider(create: (_) => ExperimentService()),
        Provider(create: (_) => AudioVibrationService()),
      ],
      child: MaterialApp(
        title: 'AR Chemistry Lab',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
