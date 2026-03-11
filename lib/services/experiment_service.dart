import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ar_chemistry_lab/models/experiment_model.dart';

class ExperimentService {
  static final ExperimentService _instance = ExperimentService._internal();
  List<Experiment>? _experiments;

  ExperimentService._internal();

  factory ExperimentService() {
    return _instance;
  }

  Future<List<Experiment>> loadExperiments() async {
    if (_experiments != null) {
      return _experiments!;
    }

    try {
      final String response = await rootBundle.loadString('assets/experiments.json');
      final List<dynamic> data = jsonDecode(response) as List<dynamic>;
      _experiments = data
          .map((e) => Experiment.fromJson(e as Map<String, dynamic>))
          .toList();
      return _experiments!;
    } catch (e) {
      print('Error loading experiments: $e');
      // Return default experiments if file not found
      return _getDefaultExperiments();
    }
  }

  Future<Experiment?> getExperimentById(String id) async {
    final experiments = await loadExperiments();
    try {
      return experiments.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Experiment> _getDefaultExperiments() {
    return [
      Experiment(
        id: '1',
        title: 'Acid-Base Neutralization',
        objective: 'Understand how acids and bases neutralize each other',
        description:
            'Observe the reaction between hydrochloric acid and sodium hydroxide to form salt and water.',
        equipmentList: ['Beaker', 'Measuring Cylinder', 'Glass Rod', 'Thermometer'],
        chemicalsUsed: [
          Chemical(
              name: 'Hydrochloric Acid',
              formula: 'HCl',
              quantity: 50,
              unit: 'mL',
              hazard: 'Corrosive'),
          Chemical(
              name: 'Sodium Hydroxide',
              formula: 'NaOH',
              quantity: 40,
              unit: 'mL',
              hazard: 'Corrosive'),
        ],
        procedureSteps: [
          'Pour 50 mL of HCl into a beaker',
          'Measure the initial temperature',
          'Slowly add NaOH while stirring',
          'Observe color change and temperature change',
          'Complete reaction when solution is neutral',
        ],
        reactionEquation: 'HCl + NaOH → NaCl + H₂O',
        safetyNotes: [
          'Wear safety goggles',
          'Use protective gloves',
          'Work in well-ventilated area',
          'Do not directly smell chemicals',
        ],
        reactionType: 'HCl_NaOH',
        difficultyLevel: 2,
        estimatedTime: 20,
        visualEffects: ['colorChange', 'heatGlow'],
        quizQuestions: [
          QuizQuestion(
            id: '1',
            question: 'What is produced when HCl reacts with NaOH?',
            options: ['NaCl + H₂O', 'NaCl + O₂', 'NaH + Cl₂O', 'HNaCl + O'],
            correctAnswer: 'NaCl + H₂O',
            explanation: 'This is a neutralization reaction producing salt and water.',
          ),
          QuizQuestion(
            id: '2',
            question: 'Why does the temperature increase?',
            options: [
              'Endothermic reaction',
              'Exothermic reaction',
              'Heat from burner',
              'No temperature change'
            ],
            correctAnswer: 'Exothermic reaction',
            explanation: 'Neutralization reactions release heat energy.',
          ),
        ],
      ),
      Experiment(
        id: '2',
        title: 'Silver Chloride Precipitation',
        objective: 'Observe precipitation of insoluble solids',
        description:
            'Mix silver nitrate with sodium chloride to form white precipitate of silver chloride.',
        equipmentList: ['Beaker', 'Test Tube', 'Dropper', 'Measuring Cylinder'],
        chemicalsUsed: [
          Chemical(
              name: 'Silver Nitrate',
              formula: 'AgNO₃',
              quantity: 20,
              unit: 'mL',
              hazard: 'Toxic'),
          Chemical(
              name: 'Sodium Chloride',
              formula: 'NaCl',
              quantity: 20,
              unit: 'mL',
              hazard: 'Safe'),
        ],
        procedureSteps: [
          'Pour silver nitrate solution into test tube',
          'Add sodium chloride dropwise',
          'Observe white precipitate forming',
          'Stir to mix thoroughly',
        ],
        reactionEquation: 'AgNO₃ + NaCl → AgCl↓ + NaNO₃',
        safetyNotes: [
          'Silver nitrate stains skin',
          'Wear gloves',
          'Avoid skin contact',
        ],
        reactionType: 'AgNO3_NaCl',
        difficultyLevel: 2,
        estimatedTime: 15,
        visualEffects: ['precipitate', 'gasBubbles'],
        quizQuestions: [
          QuizQuestion(
            id: '1',
            question: 'What color is the precipitate formed?',
            options: ['Blue', 'White', 'Yellow', 'Red'],
            correctAnswer: 'White',
            explanation: 'Silver chloride forms a white precipitate.',
          ),
        ],
      ),
      Experiment(
        id: '3',
        title: 'Magnesium Combustion',
        objective: 'Observe exothermic combustion reaction',
        description: 'Burn magnesium ribbon in air to form white magnesium oxide.',
        equipmentList: ['Crucible', 'Bunsen Burner', 'Tongs', 'Tripod Stand', 'Wire Gauze'],
        chemicalsUsed: [
          Chemical(
              name: 'Magnesium',
              formula: 'Mg',
              quantity: 2,
              unit: 'g',
              hazard: 'Flammable'),
        ],
        procedureSteps: [
          'Place magnesium ribbon in crucible',
          'Heat with Bunsen burner',
          'Observe bright flame',
          'Allow to cool',
          'Check white powder residue',
        ],
        reactionEquation: '2Mg + O₂ → 2MgO',
        safetyNotes: [
          'Do not look directly at flame',
          'Use dark glasses for protection',
          'Keep away from flammable materials',
          'Allow to cool before handling',
        ],
        reactionType: 'Mg_O2',
        difficultyLevel: 3,
        estimatedTime: 25,
        visualEffects: ['flame', 'heatGlow', 'spark'],
        quizQuestions: [
          QuizQuestion(
            id: '1',
            question: 'What is produced when magnesium burns?',
            options: ['MgO (white)', 'MgO₂ (black)', 'Mg₂O (gray)', 'MgOH (brown)'],
            correctAnswer: 'MgO (white)',
            explanation: 'Magnesium oxide is a white solid produced from combustion.',
          ),
        ],
      ),
    ];
  }
}
