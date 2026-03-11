import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _soundEnabled;
  late bool _vibrationEnabled;
  late bool _darkMode;

  @override
  void initState() {
    super.initState();
    _soundEnabled = true;
    _vibrationEnabled = true;
    _darkMode = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sound & Vibration Settings
            Text(
              'Sound & Vibration',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Sound Effects'),
              subtitle: const Text('Enable reaction sounds'),
              value: _soundEnabled,
              onChanged: (value) {
                setState(() => _soundEnabled = value);
              },
            ),
            SwitchListTile(
              title: const Text('Vibration Feedback'),
              subtitle: const Text('Haptic feedback on reactions'),
              value: _vibrationEnabled,
              onChanged: (value) {
                setState(() => _vibrationEnabled = value);
              },
            ),

            const SizedBox(height: 24),

            // Display Settings
            Text(
              'Display',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: const Text('Easier on the eyes'),
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
              },
            ),

            const SizedBox(height: 24),

            // Educational Settings
            Text(
              'Educational',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Safety Warnings'),
              subtitle: const Text('Show safety precautions'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('Detailed Explanations'),
              subtitle: const Text('Show in-depth descriptions'),
              value: true,
              onChanged: (value) {},
            ),

            // Connectivity
            Consumer<AppState>(
              builder: (context, appState, _) {
                return SwitchListTile(
                  title: const Text('Online Mode'),
                  subtitle: const Text('Use internet features'),
                  value: appState.isOnline,
                  onChanged: (value) {
                    appState.setOnline(value);
                  },
                );
              },
            ),

            const SizedBox(height: 24),

            // Data & Privacy
            Text(
              'Data & Privacy',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Clear All Data'),
              subtitle: const Text('Reset app to default state'),
              trailing: const Icon(Icons.delete_outline, color: Colors.red),
              onTap: _showClearDataDialog,
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.open_in_new),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening privacy policy...')),
                );
              },
            ),

            const SizedBox(height: 24),

            // About
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('App Version'),
              trailing: const Text('1.0.0'),
            ),
            ListTile(
              title: const Text('Build Number'),
              trailing: const Text('1'),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will reset your progress, scores, and completed experiments. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement clear data logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data cleared')),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}