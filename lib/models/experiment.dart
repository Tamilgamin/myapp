class Experiment {
  final int id;
  final String title;
  final String description;
  final String objective;
  final String category;
  final int difficulty; // 1-5
  final List<String> equipmentNeeded;
  final List<String> chemicalsUsed;
  final List<ProcedureStep> steps;
  final String reactionEquation;
  final List<String> safetyNotes;
  final String visualEffect; // 'color_change', 'bubbles', 'precipitate', etc.
  final int estimatedTime; // in minutes
  final int rewardsPoints;
  final List<String> tags;
  final List<String> quizQuestions;
  final String imageUrl;
  final bool isPremium;

  Experiment({
    required this.id,
    required this.title,
    required this.description,
    required this.objective,
    required this.category,
    required this.difficulty,
    required this.equipmentNeeded,
    required this.chemicalsUsed,
    required this.steps,
    required this.reactionEquation,
    required this.safetyNotes,
    required this.visualEffect,
    required this.estimatedTime,
    required this.rewardsPoints,
    required this.tags,
    required this.quizQuestions,
    required this.imageUrl,
    required this.isPremium,
  });

  factory Experiment.fromJson(Map<String, dynamic> json) {
    return Experiment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      objective: json['objective'],
      category: json['category'],
      difficulty: json['difficulty'],
      equipmentNeeded: List<String>.from(json['equipmentNeeded']),
      chemicalsUsed: List<String>.from(json['chemicalsUsed']),
      steps: (json['steps'] as List).map((s) => ProcedureStep.fromJson(s)).toList(),
      reactionEquation: json['reactionEquation'],
      safetyNotes: List<String>.from(json['safetyNotes']),
      visualEffect: json['visualEffect'],
      estimatedTime: json['estimatedTime'],
      rewardsPoints: json['rewardsPoints'],
      tags: List<String>.from(json['tags']),
      quizQuestions: List<String>.from(json['quizQuestions']),
      imageUrl: json['imageUrl'],
      isPremium: json['isPremium'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'objective': objective,
    'category': category,
    'difficulty': difficulty,
    'equipmentNeeded': equipmentNeeded,
    'chemicalsUsed': chemicalsUsed,
    'steps': steps.map((s) => s.toJson()).toList(),
    'reactionEquation': reactionEquation,
    'safetyNotes': safetyNotes,
    'visualEffect': visualEffect,
    'estimatedTime': estimatedTime,
    'rewardsPoints': rewardsPoints,
    'tags': tags,
    'quizQuestions': quizQuestions,
    'imageUrl': imageUrl,
    'isPremium': isPremium,
  };
}

class ProcedureStep {
  final int stepNumber;
  final String description;
  final String equipment; // equipment to highlight
  final String action; // what the user should do
  final Duration estimatedDuration;
  final List<String> chemicals;
  final String? visualIndicator; // what to look for
  final String? safetyTip;

  ProcedureStep({
    required this.stepNumber,
    required this.description,
    required this.equipment,
    required this.action,
    required this.estimatedDuration,
    required this.chemicals,
    this.visualIndicator,
    this.safetyTip,
  });

  factory ProcedureStep.fromJson(Map<String, dynamic> json) {
    return ProcedureStep(
      stepNumber: json['stepNumber'],
      description: json['description'],
      equipment: json['equipment'],
      action: json['action'],
      estimatedDuration: Duration(seconds: json['estimatedDuration']),
      chemicals: List<String>.from(json['chemicals']),
      visualIndicator: json['visualIndicator'],
      safetyTip: json['safetyTip'],
    );
  }

  Map<String, dynamic> toJson() => {
    'stepNumber': stepNumber,
    'description': description,
    'equipment': equipment,
    'action': action,
    'estimatedDuration': estimatedDuration.inSeconds,
    'chemicals': chemicals,
    'visualIndicator': visualIndicator,
    'safetyTip': safetyTip,
  };
}
