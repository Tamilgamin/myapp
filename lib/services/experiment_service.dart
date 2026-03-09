import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ar_chemistry_lab/models/experiment.dart';

class ExperimentService {
  static final ExperimentService _instance = ExperimentService._internal();
  late List<Experiment> _experiments = [];
  late final Map<String, Experiment> _experimentsMap = {};

  factory ExperimentService() {
    return _instance;
  }

  ExperimentService._internal();

  Future<void> loadExperiments() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/experiments.json');
      final jsonData = jsonDecode(jsonString);
      
      _experiments = (jsonData['experiments'] as List)
          .map((exp) => Experiment.fromJson(exp))
          .toList();
      
      for (var exp in _experiments) {
        _experimentsMap[exp.id.toString()] = exp;
      }
    } catch (e) {
      print('Error loading experiments: $e');
      _experiments = [];
    }
  }

  List<Experiment> getAllExperiments() => _experiments;

  Experiment? getExperimentById(int id) => _experimentsMap[id.toString()];

  List<Experiment> getExperimentsByCategory(String category) {
    return _experiments.where((exp) => exp.category == category).toList();
  }

  List<Experiment> getExperimentsByDifficulty(int difficulty) {
    return _experiments.where((exp) => exp.difficulty == difficulty).toList();
  }

  List<Experiment> searchExperiments(String query) {
    final lowerQuery = query.toLowerCase();
    return _experiments
        .where((exp) =>
            exp.title.toLowerCase().contains(lowerQuery) ||
            exp.description.toLowerCase().contains(lowerQuery) ||
            exp.tags.any((tag) => tag.toLowerCase().contains(lowerQuery)))
        .toList();
  }

  List<String> getAllCategories() {
    final categories = <String>{};
    for (var exp in _experiments) {
      categories.add(exp.category);
    }
    return categories.toList();
  }

  List<Experiment> getRecommendedExperiments(List<int> completedIds) {
    return _experiments
        .where((exp) => !completedIds.contains(exp.id))
        .toList()
        .take(5)
        .toList();
  }
}
