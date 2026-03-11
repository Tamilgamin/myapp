import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ar_chemistry_lab/services/app_state.dart';
import 'package:ar_chemistry_lab/models/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  final String experimentId;

  const QuizScreen({Key? key, required this.experimentId}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<QuizQuestion> questions;
  int currentQuestionIndex = 0;
  int score = 0;
  bool answered = false;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() {
    // Sample quiz questions for experiments
    questions = [
      QuizQuestion(
        id: '1',
        question: 'What is the product of HCl + NaOH reaction?',
        options: ['NaCl + H₂O', 'NaCl + O₂', 'Na + HCl₂', 'NaOH + HCl'],
        correctAnswer: 'NaCl + H₂O',
        explanation: 'This is a neutralization reaction between strong acid and strong base.',
      ),
      QuizQuestion(
        id: '2',
        question: 'In precipitation reactions, what forms?',
        options: ['Gas', 'Heat', 'Solid precipitate', 'Flame'],
        correctAnswer: 'Solid precipitate',
        explanation: 'Precipitation occurs when two soluble salts react to form an insoluble solid.',
      ),
      QuizQuestion(
        id: '3',
        question: 'What color does AgCl precipitate form?',
        options: ['Blue', 'White', 'Green', 'Yellow'],
        correctAnswer: 'White',
        explanation: 'Silver chloride (AgCl) is a white solid precipitate.',
      ),
      QuizQuestion(
        id: '4',
        question: 'Which reaction type releases heat?',
        options: ['Endothermic', 'Exothermic', 'Isothermic', 'Photochemical'],
        correctAnswer: 'Exothermic',
        explanation: 'Exothermic reactions release heat energy to the surroundings.',
      ),
      QuizQuestion(
        id: '5',
        question: 'What is the purpose of a burette in chemistry?',
        options: [
          'Heating liquids',
          'Precise measurement of liquids',
          'Mixing solutions',
          'Filtering solids'
        ],
        correctAnswer: 'Precise measurement of liquids',
        explanation: 'Burettes are used for precise titration and measurement of liquids.',
      ),
    ];
  }

  void selectAnswer(String answer) {
    if (!answered) {
      setState(() {
        selectedAnswer = answer;
        answered = true;
        if (answer == questions[currentQuestionIndex].correctAnswer) {
          score += 20; // Each question worth 20 points
        }
      });
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        answered = false;
      });
    } else {
      completeQuiz();
    }
  }

  void completeQuiz() {
    final appState = context.read<AppState>();
    appState.addQuizScore(widget.experimentId, score);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$score/100',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              score >= 70 ? '🎉 Great job!' : '📚 Keep practicing!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close quiz screen
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(Colors.blue.shade600),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Options
            ...question.options.map((option) {
              final isSelected = selectedAnswer == option;
              final isCorrect = option == question.correctAnswer;
              final showResult = answered;

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => selectAnswer(option),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: showResult
                            ? (isCorrect
                                ? Colors.green
                                : isSelected
                                    ? Colors.red
                                    : Colors.grey[300]!)
                            : (isSelected ? Colors.blue : Colors.grey[300]!),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: showResult
                          ? (isCorrect
                              ? Colors.green.withOpacity(0.1)
                              : isSelected
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.white)
                          : (isSelected ? Colors.blue.withOpacity(0.1) : Colors.white),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: showResult
                                      ? (isCorrect
                                          ? Colors.green
                                          : isSelected
                                              ? Colors.red
                                              : Colors.black)
                                      : Colors.black,
                                ),
                          ),
                        ),
                        if (showResult && isCorrect)
                          const Icon(Icons.check_circle, color: Colors.green)
                        else if (showResult && isSelected && !isCorrect)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),

            if (answered) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explanation',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.explanation,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  child: Text(
                    currentQuestionIndex == questions.length - 1
                        ? 'Finish Quiz'
                        : 'Next Question',
                  ),
                ),
              ),
            ],

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    'Score so far: $score points',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
