class UserProgress {
  final String userId;
  final int totalScore;
  final List<int> completedExperiments;
  final List<QuizScore> quizScores;
  final DateTime lastActivity;
  final int totalTimeSpent; // in minutes
  final int level;
  final List<String> unlockedAchievements;
  final Map<String, dynamic> preferences;

  UserProgress({
    required this.userId,
    required this.totalScore,
    required this.completedExperiments,
    required this.quizScores,
    required this.lastActivity,
    required this.totalTimeSpent,
    required this.level,
    required this.unlockedAchievements,
    required this.preferences,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'],
      totalScore: json['totalScore'],
      completedExperiments: List<int>.from(json['completedExperiments']),
      quizScores: (json['quizScores'] as List?)?.map((q) => QuizScore.fromJson(q)).toList() ?? [],
      lastActivity: DateTime.parse(json['lastActivity']),
      totalTimeSpent: json['totalTimeSpent'],
      level: json['level'],
      unlockedAchievements: List<String>.from(json['unlockedAchievements'] ?? []),
      preferences: json['preferences'] ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'totalScore': totalScore,
    'completedExperiments': completedExperiments,
    'quizScores': quizScores.map((q) => q.toJson()).toList(),
    'lastActivity': lastActivity.toIso8601String(),
    'totalTimeSpent': totalTimeSpent,
    'level': level,
    'unlockedAchievements': unlockedAchievements,
    'preferences': preferences,
  };
}

class QuizScore {
  final int experimentId;
  final int score;
  final int totalQuestions;
  final DateTime completedAt;
  final List<bool> answers;

  QuizScore({
    required this.experimentId,
    required this.score,
    required this.totalQuestions,
    required this.completedAt,
    required this.answers,
  });

  factory QuizScore.fromJson(Map<String, dynamic> json) {
    return QuizScore(
      experimentId: json['experimentId'],
      score: json['score'],
      totalQuestions: json['totalQuestions'],
      completedAt: DateTime.parse(json['completedAt']),
      answers: List<bool>.from(json['answers']),
    );
  }

  Map<String, dynamic> toJson() => {
    'experimentId': experimentId,
    'score': score,
    'totalQuestions': totalQuestions,
    'completedAt': completedAt.toIso8601String(),
    'answers': answers,
  };
}
