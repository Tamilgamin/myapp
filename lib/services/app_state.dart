import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  int _score = 0;
  List<String> _completedExperiments = [];
  bool _isOnline = true;
  Map<String, int> _quizScores = {};
  List<Map<String, dynamic>> _leaderboard = [];

  int get score => _score;
  List<String> get completedExperiments => _completedExperiments;
  bool get isOnline => _isOnline;
  Map<String, int> get quizScores => _quizScores;

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _score = prefs.getInt('score') ?? 0;
    _completedExperiments = prefs.getStringList('completed') ?? [];
    
    // Load quiz scores
    final quizScoresStr = prefs.getString('quizScores');
    if (quizScoresStr != null) {
      _quizScores = Map<String, int>.from(
        quizScoresStr.split(',').fold({}, (map, item) {
          final parts = item.split(':');
          if (parts.length == 2) {
            map[parts[0]] = int.parse(parts[1]);
          }
          return map;
        })
      );
    }
    
    _buildLeaderboard();
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', _score);
    await prefs.setStringList('completed', _completedExperiments);
    
    // Save quiz scores
    final quizScoresStr = _quizScores.entries
        .map((e) => '${e.key}:${e.value}')
        .join(',');
    await prefs.setString('quizScores', quizScoresStr);
  }

  void addScore(int points) {
    _score += points;
    _buildLeaderboard();
    saveData();
    notifyListeners();
  }

  void addQuizScore(String experimentId, int score) {
    _score += score;
    _quizScores[experimentId] = score;
    _buildLeaderboard();
    saveData();
    notifyListeners();
  }

  void completeExperiment(String id) {
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

  List<Map<String, dynamic>> getLeaderboard() {
    return _leaderboard;
  }

  void _buildLeaderboard() {
    _leaderboard = [
      {'experimentId': 'You', 'score': _score},
      {'experimentId': 'Top Player', 'score': _score + 50},
      {'experimentId': 'Expert', 'score': _score + 100},
      {'experimentId': 'Master', 'score': _score + 150},
      {'experimentId': 'Legend', 'score': _score + 200},
    ];
    
    _leaderboard.sort((a, b) => (b['score'] as int).compareTo(a['score'] as int));
  }

  int getExperimentProgress() {
    return (_completedExperiments.length * 100) ~/ 100;
  }

  Map<String, dynamic> getUserStats() {
    return {
      'totalScore': _score,
      'experimentsCompleted': _completedExperiments.length,
      'quizzesCompleted': _quizScores.length,
      'averageQuizScore': _quizScores.isEmpty
          ? 0
          : (_quizScores.values.reduce((a, b) => a + b) ~/ _quizScores.length),
    };
  }

  Future<void> clearAllData() async {
    _score = 0;
    _completedExperiments = [];
    _quizScores = {};
    _buildLeaderboard();
    await saveData();
    notifyListeners();
  }
}