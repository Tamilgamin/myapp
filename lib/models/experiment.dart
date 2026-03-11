// ignore_for_file: non_constant_identifier_names

class Experiment {
  final int id;
  final String title;
  final String objective;
  final String description;
  final List<String> equipmentList;
  final List<String> chemicalsUsed;
  final List<ProcedureStep> procedureSteps;
  final String reactionEquation;
  final List<String> safetyNotes;
  final String reactionType; // 'neutralization', 'precipitation', 'gas', 'combustion', 'oxidation'
  final List<String> colors; // Color progression for visual effect
  final List<QuizQuestion> quizQuestions;
  final int difficulty; // 1-5
  final int pointsReward;
  final bool isLocked;

  Experiment({
    required this.id,
    required this.title,
    required this.objective,
    required this.description,
    required this.equipmentList,
    required this.chemicalsUsed,
    required this.procedureSteps,
    required this.reactionEquation,
    required this.safetyNotes,
    required this.reactionType,
    required this.colors,
    required this.quizQuestions,
    required this.difficulty,
    required this.pointsReward,
    this.isLocked = false,
  });

  factory Experiment.fromJson(Map<String, dynamic> json) {
    return Experiment(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      objective: json['objective'] ?? '',
      description: json['description'] ?? '',
      equipmentList: List<String>.from(json['equipmentList'] ?? []),
      chemicalsUsed: List<String>.from(json['chemicalsUsed'] ?? []),
      procedureSteps: (json['procedureSteps'] as List?)
          ?.map((step) => ProcedureStep.fromJson(step))
          .toList() ?? [],
      reactionEquation: json['reactionEquation'] ?? '',
      safetyNotes: List<String>.from(json['safetyNotes'] ?? []),
      reactionType: json['reactionType'] ?? 'neutralization',
      colors: List<String>.from(json['colors'] ?? []),
      quizQuestions: (json['quizQuestions'] as List?)
          ?.map((q) => QuizQuestion.fromJson(q))
          .toList() ?? [],
      difficulty: json['difficulty'] ?? 1,
      pointsReward: json['pointsReward'] ?? 10,
      isLocked: json['isLocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'objective': objective,
    'description': description,
    'equipmentList': equipmentList,
    'chemicalsUsed': chemicalsUsed,
    'procedureSteps': procedureSteps.map((e) => e.toJson()).toList(),
    'reactionEquation': reactionEquation,
    'safetyNotes': safetyNotes,
    'reactionType': reactionType,
    'colors': colors,
    'quizQuestions': quizQuestions.map((e) => e.toJson()).toList(),
    'difficulty': difficulty,
    'pointsReward': pointsReward,
    'isLocked': isLocked,
  };
}

class ProcedureStep {
  final int stepNumber;
  final String instruction;
  final List<String> equipment;
  final String expectedOutcome;
  final String animation; // 'pour', 'burn', 'mix', 'heat'

  ProcedureStep({
    required this.stepNumber,
    required this.instruction,
    required this.equipment,
    required this.expectedOutcome,
    required this.animation,
  });

  factory ProcedureStep.fromJson(Map<String, dynamic> json) {
    return ProcedureStep(
      stepNumber: json['stepNumber'] ?? 0,
      instruction: json['instruction'] ?? '',
      equipment: List<String>.from(json['equipment'] ?? []),
      expectedOutcome: json['expectedOutcome'] ?? '',
      animation: json['animation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'stepNumber': stepNumber,
    'instruction': instruction,
    'equipment': equipment,
    'expectedOutcome': expectedOutcome,
    'animation': animation,
  };
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswerIndex: json['correctAnswerIndex'] ?? 0,
      explanation: json['explanation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'question': question,
    'options': options,
    'correctAnswerIndex': correctAnswerIndex,
    'explanation': explanation,
  };
}
