import 'package:flutter/material.dart';
import 'package:ar_chemistry_lab/services/audio_service.dart';
import 'package:ar_chemistry_lab/services/ar_service.dart';

class ReactionEngine {
  static final ReactionEngine _instance = ReactionEngine._internal();
  static final AudioService _audioService = AudioService();
  static final ARService _arService = ARService();

  factory ReactionEngine() {
    return _instance;
  }

  ReactionEngine._internal();

  Future<void> simulateReaction(
    String reactionType,
    List<String> colors,
    BuildContext context,
  ) async {
    switch (reactionType) {
      case 'neutralization':
        await _simulateNeutralization(colors, context);
        break;
      case 'precipitation':
        await _simulatePrecipitation(colors, context);
        break;
      case 'gas':
        await _simulateGasProduction(colors, context);
        break;
      case 'combustion':
        await _simulateCombustion(colors, context);
        break;
      case 'oxidation':
        await _simulateOxidation(colors, context);
        break;
      case 'decomposition':
        await _simulateDecomposition(colors, context);
        break;
      case 'synthesis':
        await _simulateSynthesis(colors, context);
        break;
      default:
        break;
    }
  }

  Future<void> _simulateNeutralization(List<String> colors, BuildContext context) async {
    // Play neutralization sound
    await _audioService.playSound('neutralization');
    
    // Vibration feedback
    await _audioService.vibrate(duration: 200);
    
    // Visual feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Neutralization: Colors change as acid meets base!'),
        duration: Duration(seconds: 2),
      ),
    );
    
    // AR visual effect - color transitions
    for (final color in colors) {
      _arService.simulateReactionVisual('neutralization', colors: colors);
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> _simulatePrecipitation(List<String> colors, BuildContext context) async {
    await _audioService.playSound('precipitation');
    await _audioService.vibrate(duration: 150);
    await _audioService.vibrate(duration: 150);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Precipitation: White solid particles form!'),
        duration: Duration(seconds: 2),
      ),
    );

    _arService.simulateReactionVisual('precipitation', colors: colors);
  }

  Future<void> _simulateGasProduction(List<String> colors, BuildContext context) async {
    await _audioService.playSound('bubbling');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gas Production: Bubbles are rising!'),
        duration: Duration(seconds: 2),
      ),
    );

    // Simulate multiple pops for bubble effect
    for (int i = 0; i < 5; i++) {
      await _audioService.vibrate(duration: 100);
      await Future.delayed(const Duration(milliseconds: 200));
    }

    _arService.simulateReactionVisual('gas', colors: colors);
  }

  Future<void> _simulateCombustion(List<String> colors, BuildContext context) async {
    await _audioService.playSound('combustion');
    
    for (int i = 0; i < 3; i++) {
      await _audioService.vibrate(duration: 300);
      await Future.delayed(const Duration(milliseconds: 100));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Combustion: Bright flames and heat!'),
        duration: Duration(seconds: 2),
      ),
    );

    _arService.simulateReactionVisual('combustion', colors: colors);
  }

  Future<void> _simulateOxidation(List<String> colors, BuildContext context) async {
    await _audioService.playSound('oxidation');
    await _audioService.vibrate(duration: 200);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Oxidation: Material changes color!'),
        duration: Duration(seconds: 2),
      ),
    );

    _arService.simulateReactionVisual('oxidation', colors: colors);
  }

  Future<void> _simulateDecomposition(List<String> colors, BuildContext context) async {
    await _audioService.playSound('decomposition');

    for (int i = 0; i < 4; i++) {
      await _audioService.vibrate(duration: 100);
      await Future.delayed(const Duration(milliseconds: 150));
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Decomposition: Compound breaks apart!'),
        duration: Duration(seconds: 2),
      ),
    );

    _arService.simulateReactionVisual('decomposition', colors: colors);
  }

  Future<void> _simulateSynthesis(List<String> colors, BuildContext context) async {
    await _audioService.playSound('synthesis');
    await _audioService.vibrate(duration: 200);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Synthesis: New compound is formed!'),
        duration: Duration(seconds: 2),
      ),
    );

    _arService.simulateReactionVisual('synthesis', colors: colors);
  }
}