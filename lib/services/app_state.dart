import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  int _score = 0;
  List<int> _completedExperiments = [];
  bool _isOnline = true;

  int get score => _score;
  List<int> get completedExperiments => _completedExperiments;
  bool get isOnline => _isOnline;

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _score = prefs.getInt('score') ?? 0;
    _completedExperiments = prefs.getStringList('completed')?.map(int.parse).toList() ?? [];
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', _score);
    await prefs.setStringList('completed', _completedExperiments.map((e) => e.toString()).toList());
  }

  void addScore(int points) {
    _score += points;
    saveData();
    notifyListeners();
  }

  void completeExperiment(int id) {
    if (!_completedExperiments.contains(id)) {
      _completedExperiments.add(id);
      saveData();
      notifyListeners();
    }
  }

  void setOnline(bool online) {
    _isOnline = online;
    notifyListeners();
  }
}