class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'question': question,
    'options': options,
    'correctAnswer': correctAnswer,
    'explanation': explanation,
  };

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
    id: json['id'] as String,
    question: json['question'] as String,
    options: List<String>.from(json['options'] as List),
    correctAnswer: json['correctAnswer'] as String,
    explanation: json['explanation'] as String,
  );
}

class QuizResult {
  final String experimentId;
  final int score;
  final int totalQuestions;
  final List<String> answeredCorrectly;
  final DateTime completedAt;

  QuizResult({
    required this.experimentId,
    required this.score,
    required this.totalQuestions,
    required this.answeredCorrectly,
    required this.completedAt,
  });

  double getPercentage() {
    return (score / totalQuestions) * 100;
  }

  bool passed() {
    return getPercentage() >= 70;
  }
}
