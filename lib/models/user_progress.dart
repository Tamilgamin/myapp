class UserProgress {
  final int userId;
  final int totalScore;
  final int rank;
  final int experimentsCompleted;
  final int quizzesAnsweredCorrectly;
  final DateTime lastActiveDate;
  final List<int> unlockedExperiments;
  final List<int> completedQuizzes;

  UserProgress({
    required this.userId,
    required this.totalScore,
    required this.rank,
    required this.experimentsCompleted,
    required this.quizzesAnsweredCorrectly,
    required this.lastActiveDate,
    required this.unlockedExperiments,
    required this.completedQuizzes,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      userId: json['userId'] ?? 0,
      totalScore: json['totalScore'] ?? 0,
      rank: json['rank'] ?? 0,
      experimentsCompleted: json['experimentsCompleted'] ?? 0,
      quizzesAnsweredCorrectly: json['quizzesAnsweredCorrectly'] ?? 0,
      lastActiveDate: DateTime.tryParse(json['lastActiveDate'] ?? '') ?? DateTime.now(),
      unlockedExperiments: List<int>.from(json['unlockedExperiments'] ?? []),
      completedQuizzes: List<int>.from(json['completedQuizzes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'totalScore': totalScore,
    'rank': rank,
    'experimentsCompleted': experimentsCompleted,
    'quizzesAnsweredCorrectly': quizzesAnsweredCorrectly,
    'lastActiveDate': lastActiveDate.toIso8601String(),
    'unlockedExperiments': unlockedExperiments,
    'completedQuizzes': completedQuizzes,
  };
}

class LeaderboardEntry {
  final String userName;
  final int score;
  final int rank;
  final int experimentsCompleted;

  LeaderboardEntry({
    required this.userName,
    required this.score,
    required this.rank,
    required this.experimentsCompleted,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userName: json['userName'] ?? '',
      score: json['score'] ?? 0,
      rank: json['rank'] ?? 0,
      experimentsCompleted: json['experimentsCompleted'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'score': score,
    'rank': rank,
    'experimentsCompleted': experimentsCompleted,
  };
}
