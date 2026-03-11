import 'package:flutter/material.dart';
import 'package:ar_chemistry_lab/models/experiment.dart';
import 'package:ar_chemistry_lab/utils/constants.dart';
import 'package:ar_chemistry_lab/utils/colors.dart';

class QuizScreen extends StatefulWidget {
  final Experiment experiment;

  const QuizScreen({
    super.key,
    required this.experiment,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  late List<int?> selectedAnswers;

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>(widget.experiment.quizQuestions.length);
  }

  void _nextQuestion() {
    final question = widget.experiment.quizQuestions[currentQuestionIndex];
    
    if (selectedAnswers[currentQuestionIndex] == question.correctAnswerIndex) {
      score += AppConstants.pointsPerQuizQuestion;
    }

    if (currentQuestionIndex < widget.experiment.quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showResults();
    }
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $score/${AppConstants.pointsPerQuizQuestion * widget.experiment.quizQuestions.length}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Percentage: ${((score / (AppConstants.pointsPerQuizQuestion * widget.experiment.quizQuestions.length)) * 100).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.experiment.quizQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz - ${widget.experiment.title}'),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryGradient,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.spacingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress indicator
                LinearProgressIndicator(
                  value: (currentQuestionIndex + 1) / widget.experiment.quizQuestions.length,
                  minHeight: 8,
                ),
                const SizedBox(height: AppConstants.spacingLarge),
                
                // Question counter
                Text(
                  'Question ${currentQuestionIndex + 1}/${widget.experiment.quizQuestions.length}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: AppConstants.fontSizeMedium,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingMedium),

                // Question
                Text(
                  question.question,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: AppConstants.fontSizeXLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingLarge),

                // Options
                ...List.generate(
                  question.options.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppConstants.spacingMedium,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAnswers[currentQuestionIndex] = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppConstants.spacingMedium),
                        decoration: BoxDecoration(
                          color: selectedAnswers[currentQuestionIndex] == index
                              ? Colors.white
                              : Colors.white24,
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusMedium,
                          ),
                          border: Border.all(
                            color: selectedAnswers[currentQuestionIndex] == index
                                ? AppColors.success
                                : Colors.white12,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          question.options[index],
                          style: TextStyle(
                            color: selectedAnswers[currentQuestionIndex] == index
                                ? Colors.blue
                                : Colors.white,
                            fontSize: AppConstants.fontSizeLarge,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedAnswers[currentQuestionIndex] != null ? _nextQuestion : null,
        label: Text(
          currentQuestionIndex == widget.experiment.quizQuestions.length - 1
              ? 'Submit'
              : 'Next',
        ),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
