import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/screens/experiment_library_screen.dart';
import 'package:ar_chemistry_lab/screens/ai_assistant_screen.dart';
import 'package:ar_chemistry_lab/screens/leaderboard_screen.dart';
import 'package:ar_chemistry_lab/screens/settings_screen.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Chemistry Lab'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.science,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'AR Chemistry Lab',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              _buildButton(context, 'Start Experiment', () {
                // Navigate to AR experiment
              }),
              _buildButton(context, 'Experiment Library', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExperimentLibraryScreen()),
                );
              }),
              _buildButton(context, 'AI Chemistry Teacher', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AIAssistantScreen()),
                );
              }),
              _buildButton(context, 'Leaderboard', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LeaderboardScreen()),
                );
              }),
              _buildButton(context, 'Settings', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: Colors.white.withOpacity(0.2),
          foregroundColor: Colors.white,
        ),
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}