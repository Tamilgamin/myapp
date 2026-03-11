import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ar_chemistry_lab/models/experiment.dart';

class ExperimentService {
  static final ExperimentService _instance = ExperimentService._internal();

  factory ExperimentService() {
    return _instance;
  }

  ExperimentService._internal();

  List<Experiment> _experiments = [];
  bool _isLoaded = false;

  List<Experiment> get experiments => _experiments;
  bool get isLoaded => _isLoaded;

  Future<void> loadExperiments() async {
    if (_isLoaded) return;

    try {
      final jsonString = await rootBundle.loadString('assets/experiments.json');
      final jsonData = json.decode(jsonString);
      
      if (jsonData is Map && jsonData['experiments'] is List) {
        _experiments = (jsonData['experiments'] as List)
            .map((exp) => Experiment.fromJson(exp as Map<String, dynamic>))
            .toList();
      }
      
      _isLoaded = true;
    } catch (e) {
      print('Error loading experiments: $e');
      _isLoaded = true;
    }
  }

  Experiment? getExperimentById(int id) {
    try {
      return _experiments.firstWhere((exp) => exp.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Experiment> getExperimentsByDifficulty(int difficulty) {
    return _experiments.where((exp) => exp.difficulty == difficulty).toList();
  }

  List<Experiment> searchExperiments(String query) {
    return _experiments
        .where((exp) =>
            exp.title.toLowerCase().contains(query.toLowerCase()) ||
            exp.objective.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Experiment> getUnlockedExperiments(List<int> completedIds) {
    return _experiments
        .where((exp) => !exp.isLocked || completedIds.contains(exp.id))
        .toList();
  }
}
