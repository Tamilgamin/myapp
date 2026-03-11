import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ar_chemistry_lab/screens/home_screen.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';
import 'package:ar_chemistry_lab/services/experiment_service.dart';
import 'package:ar_chemistry_lab/services/ar_service.dart';
import 'package:ar_chemistry_lab/services/audio_service.dart';
import 'package:ar_chemistry_lab/services/ai_service.dart';
import 'package:ar_chemistry_lab/services/analytics_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Initialize services
  final experimentService = ExperimentService();
  await experimentService.loadExperiments();
  
  final arService = ARService();
  await arService.initializeAR();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ProxyProvider<AppState, ExperimentService>(
          update: (_, __, ___) => ExperimentService(),
        ),
        ProxyProvider<AppState, ARService>(
          update: (_, __, ___) => ARService(),
        ),
        ProxyProvider<AppState, AudioService>(
          update: (_, __, ___) => AudioService(),
        ),
        ProxyProvider<AppState, AIService>(
          update: (_, __, ___) => AIService(),
        ),
        ProxyProvider<AppState, AnalyticsService>(
          update: (_, __, ___) => AnalyticsService(),
        ),
      ],
      child: MaterialApp(
        title: 'AR Chemistry Lab',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
