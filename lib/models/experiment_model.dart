class Experiment {
  final String id;
  final String title;
  final String objective;
  final String description;
  final List<String> equipmentList;
  final List<Chemical> chemicalsUsed;
  final List<String> procedureSteps;
  final String reactionEquation;
  final List<String> safetyNotes;
  final String reactionType;
  final int difficultyLevel; // 1-5
  final int estimatedTime; // in minutes
  final List<String> visualEffects;
  final List<QuizQuestion> quizQuestions;
  final String imageUrl;
  bool isCompleted;
  int? quizScore;

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
    required this.difficultyLevel,
    required this.estimatedTime,
    required this.visualEffects,
    required this.quizQuestions,
    this.imageUrl = '',
    this.isCompleted = false,
    this.quizScore,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'objective': objective,
    'description': description,
    'equipmentList': equipmentList,
    'chemicalsUsed': chemicalsUsed.map((c) => c.toJson()).toList(),
    'procedureSteps': procedureSteps,
    'reactionEquation': reactionEquation,
    'safetyNotes': safetyNotes,
    'reactionType': reactionType,
    'difficultyLevel': difficultyLevel,
    'estimatedTime': estimatedTime,
    'visualEffects': visualEffects,
    'quizQuestions': quizQuestions.map((q) => q.toJson()).toList(),
    'imageUrl': imageUrl,
    'isCompleted': isCompleted,
    'quizScore': quizScore,
  };

  factory Experiment.fromJson(Map<String, dynamic> json) => Experiment(
    id: json['id'] as String,
    title: json['title'] as String,
    objective: json['objective'] as String,
    description: json['description'] as String,
    equipmentList: List<String>.from(json['equipmentList'] as List),
    chemicalsUsed: (json['chemicalsUsed'] as List)
        .map((c) => Chemical.fromJson(c as Map<String, dynamic>))
        .toList(),
    procedureSteps: List<String>.from(json['procedureSteps'] as List),
    reactionEquation: json['reactionEquation'] as String,
    safetyNotes: List<String>.from(json['safetyNotes'] as List),
    reactionType: json['reactionType'] as String,
    difficultyLevel: json['difficultyLevel'] as int,
    estimatedTime: json['estimatedTime'] as int,
    visualEffects: List<String>.from(json['visualEffects'] as List),
    quizQuestions: (json['quizQuestions'] as List)
        .map((q) => QuizQuestion.fromJson(q as Map<String, dynamic>))
        .toList(),
    imageUrl: json['imageUrl'] as String? ?? '',
    isCompleted: json['isCompleted'] as bool? ?? false,
    quizScore: json['quizScore'] as int?,
  );
}

class Chemical {
  final String name;
  final String formula;
  final double quantity;
  final String unit;
  final String hazard;

  Chemical({
    required this.name,
    required this.formula,
    required this.quantity,
    required this.unit,
    required this.hazard,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'formula': formula,
    'quantity': quantity,
    'unit': unit,
    'hazard': hazard,
  };

  factory Chemical.fromJson(Map<String, dynamic> json) => Chemical(
    name: json['name'] as String,
    formula: json['formula'] as String,
    quantity: (json['quantity'] as num).toDouble(),
    unit: json['unit'] as String,
    hazard: json['hazard'] as String,
  );
}

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

class Equipment {
  final String id;
  final String name;
  final String category;
  final String description;
  final String? imageUrl;

  Equipment({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.imageUrl,
  });

  static final List<Equipment> standardEquipment = [
    Equipment(id: '1', name: 'Beaker', category: 'Glassware', description: 'Container for liquids'),
    Equipment(id: '2', name: 'Test Tube', category: 'Glassware', description: 'Small tube for reactions'),
    Equipment(id: '3', name: 'Conical Flask', category: 'Glassware', description: 'Flask with cone shape'),
    Equipment(id: '4', name: 'Burette', category: 'Measuring', description: 'Precise liquid measurement'),
    Equipment(id: '5', name: 'Pipette', category: 'Measuring', description: 'Transfers small volumes'),
    Equipment(id: '6', name: 'Glass Rod', category: 'Tools', description: 'For stirring'),
    Equipment(id: '7', name: 'Funnel', category: 'Tools', description: 'For pouring'),
    Equipment(id: '8', name: 'Bunsen Burner', category: 'Heating', description: 'Heat source'),
    Equipment(id: '9', name: 'Evaporating Dish', category: 'Glassware', description: 'For evaporation'),
    Equipment(id: '10', name: 'Measuring Cylinder', category: 'Measuring', description: 'Volume measurement'),
  ];
}
