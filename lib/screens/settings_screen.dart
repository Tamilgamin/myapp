import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Online Mode'),
            value: appState.isOnline,
            onChanged: (value) {
              appState.setOnline(value);
            },
          ),
          ListTile(
            title: const Text('Reset Progress'),
            onTap: () {
              // Reset logic
            },
          ),
        ],
      ),
    );
  }
}