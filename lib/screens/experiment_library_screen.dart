import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:ar_chemistry_lab/screens/ar_experiment_screen.dart';

class ExperimentLibraryScreen extends StatefulWidget {
  const ExperimentLibraryScreen({super.key});

  @override
  _ExperimentLibraryScreenState createState() => _ExperimentLibraryScreenState();
}

class _ExperimentLibraryScreenState extends State<ExperimentLibraryScreen> {
  List<dynamic> experiments = [];

  @override
  void initState() {
    super.initState();
    loadExperiments();
  }

  Future<void> loadExperiments() async {
    final String response = await rootBundle.loadString('assets/experiments.json');
    final data = json.decode(response);
    setState(() {
      experiments = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment Library'),
      ),
      body: ListView.builder(
        itemCount: experiments.length,
        itemBuilder: (context, index) {
          final experiment = experiments[index];
          return ListTile(
            title: Text(experiment['title']),
            subtitle: Text(experiment['objective']),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ARExperimentScreen(experiment: experiment),
                ),
              );
            },
          );
        },
      ),
    );
  }
}