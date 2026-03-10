import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Your Score'),
            trailing: Text('${appState.score}'),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: appState.completedExperiments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Experiment ${appState.completedExperiments[index]}'),
                  trailing: const Icon(Icons.check),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}