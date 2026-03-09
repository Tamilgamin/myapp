import 'package:flutter/material.dart';
import 'package:ar_chemistry_lab/services/audio_service.dart';

class ReactionEngine {
  static final AudioService _audioService = AudioService();
  static final Map<String, ReactionEffect> _reactionEffects = {
    'color_change': ReactionEffect(
      name: 'Color Change',
      duration: Duration(seconds: 3),
      visualEffect: 'Gradual color transition',
      sound: 'mix',
    ),
    'bubbles': ReactionEffect(
      name: 'Gas Bubbles',
      duration: Duration(seconds: 5),
      visualEffect: 'Rising bubble animation',
      sound: 'bubble',
    ),
    'precipitate': ReactionEffect(
      name: 'Precipitate Formation',
      duration: Duration(seconds: 4),
      visualEffect: 'Particle settling animation',
      sound: 'glass',
    ),
    'smoke': ReactionEffect(
      name: 'Smoke Emission',
      duration: Duration(seconds: 6),
      visualEffect: 'Smoke particle effect',
      sound: 'flame',
    ),
    'flame': ReactionEffect(
      name: 'Flame Effect',
      duration: Duration(seconds: 3),
      visualEffect: 'Flame animation',
      sound: 'flame',
    ),
    'heat_glow': ReactionEffect(
      name: 'Heat Glow',
      duration: Duration(seconds: 4),
      visualEffect: 'Glowing animation',
      sound: 'flame',
    ),
    'liquid_mixing': ReactionEffect(
      name: 'Liquid Mixing',
      duration: Duration(seconds: 3),
      visualEffect: 'Swirling animation',
      sound: 'pour',
    ),
  };

  static Future<void> simulateReaction(
    String effectType, {
    VoidCallback? onComplete,
    bool playSound = true,
    bool haptic = true,
  }) async {
    final effect = _reactionEffects[effectType];
    if (effect == null) return;

    // Play sound
    if (playSound) {
      await _audioService.playSound(effect.sound);
    }

    // Haptic feedback
    if (haptic) {
      await _audioService.vibrateFeedback();
    }

    // Wait for animation duration
    await Future.delayed(effect.duration);

    // Callback when complete
    onComplete?.call();
  }

  static ReactionEffect? getReactionEffect(String effectType) {
    return _reactionEffects[effectType];
  }

  static List<String> getAllReactionTypes() {
    return _reactionEffects.keys.toList();
  }

  static Future<void> playChainReaction(List<String> effects) async {
    for (var effect in effects) {
      await simulateReaction(effect);
    }
  }

  // Specific reaction simulations
  static Future<void> simulateNeutralization() async {
    await simulateReaction('color_change');
  }

  static Future<void> simulatePrecipitation() async {
    await playChainReaction(['color_change', 'precipitate']);
  }

  static Future<void> simulateGasProduction() async {
    await playChainReaction(['bubbles', 'bubble']);
  }

  static Future<void> simulateCombustion() async {
    await playChainReaction(['flame', 'smoke', 'heat_glow']);
  }

  static Future<void> simulateBloodredPrecipitate() async {
    // Fe2+ + K3[Fe(CN)6] → Fe3[Fe(CN)6]2 (Prussian Blue)
    await playChainReaction(['color_change', 'precipitate']);
  }

  static Future<void> simulateExothermic() async {
    // Exothermic reactions with heat and glow
    await playChainReaction(['heat_glow', 'flame']);
  }
}

class ReactionEffect {
  final String name;
  final Duration duration;
  final String visualEffect;
  final String sound;

  ReactionEffect({
    required this.name,
    required this.duration,
    required this.visualEffect,
    required this.sound,
  });
}