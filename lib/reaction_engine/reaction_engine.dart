import 'package:flutter/material.dart';

enum ReactionEffectType {
  colorChange,
  gasBubbles,
  precipitate,
  liquidMixing,
  smokeEmission,
  heatGlow,
  flame,
  spark,
}

class ReactionEffect {
  final ReactionEffectType type;
  final Color startColor;
  final Color endColor;
  final Duration duration;
  final VoidCallback? onComplete;

  ReactionEffect({
    required this.type,
    this.startColor = Colors.transparent,
    this.endColor = Colors.transparent,
    this.duration = const Duration(seconds: 2),
    this.onComplete,
  });
}

class ReactionEngine {
  static final Map<String, List<ReactionEffect>> reactionEffects = {
    'HCl_NaOH': [
      // Neutralization: Color change from red to colorless
      ReactionEffect(
        type: ReactionEffectType.colorChange,
        startColor: Color.fromARGB(255, 255, 100, 100),
        endColor: Colors.transparent,
        duration: Duration(seconds: 3),
      ),
      ReactionEffect(
        type: ReactionEffectType.liquidMixing,
        duration: Duration(seconds: 2),
      ),
    ],
    'AgNO3_NaCl': [
      // Precipitation: White solid forms
      ReactionEffect(
        type: ReactionEffectType.precipitate,
        startColor: Colors.transparent,
        endColor: Colors.white,
        duration: Duration(seconds: 2),
      ),
      ReactionEffect(
        type: ReactionEffectType.gasBubbles,
        duration: Duration(seconds: 3),
      ),
    ],
    'Mg_O2': [
      // Combustion: Flame and heat glow
      ReactionEffect(
        type: ReactionEffectType.flame,
        startColor: Colors.yellow,
        endColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
      ReactionEffect(
        type: ReactionEffectType.heatGlow,
        startColor: Colors.orange,
        endColor: Colors.transparent,
        duration: Duration(seconds: 3),
      ),
      ReactionEffect(
        type: ReactionEffectType.spark,
        duration: Duration(seconds: 3),
      ),
    ],
    'CaCO3_decomposition': [
      // Thermal decomposition: Smoke and gas
      ReactionEffect(
        type: ReactionEffectType.smokeEmission,
        startColor: Color.fromARGB(128, 128, 128, 128),
        endColor: Colors.transparent,
        duration: Duration(seconds: 4),
      ),
      ReactionEffect(
        type: ReactionEffectType.gasBubbles,
        duration: Duration(seconds: 3),
      ),
    ],
    'Fe_CuSO4': [
      // Displacement: Color change and precipitate
      ReactionEffect(
        type: ReactionEffectType.colorChange,
        startColor: Colors.blue,
        endColor: Colors.teal,
        duration: Duration(seconds: 2),
      ),
      ReactionEffect(
        type: ReactionEffectType.precipitate,
        startColor: Colors.transparent,
        endColor: Colors.brown,
        duration: Duration(seconds: 3),
      ),
    ],
  };

  /// Simulate a chemical reaction with visual effects
  static Future<void> simulateReaction(
    String reactionId,
    BuildContext context, {
    VoidCallback? onReactionComplete,
  }) async {
    final effects = reactionEffects[reactionId] ?? [];

    for (final effect in effects) {
      await _playEffect(effect, context);
    }

    onReactionComplete?.call();
  }

  /// Play a single reaction effect
  static Future<void> _playEffect(
    ReactionEffect effect,
    BuildContext context,
  ) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getEffectDescription(effect.type)),
          duration: effect.duration,
          backgroundColor: _getEffectColor(effect.type),
        ),
      );

      await Future.delayed(effect.duration);
      effect.onComplete?.call();
    } catch (e) {
      debugPrint('Error playing reaction effect: $e');
    }
  }

  /// Get description text for effect type
  static String _getEffectDescription(ReactionEffectType type) {
    switch (type) {
      case ReactionEffectType.colorChange:
        return '🎨 Color changes during reaction...';
      case ReactionEffectType.gasBubbles:
        return '💨 Gas bubbles forming...';
      case ReactionEffectType.precipitate:
        return '⚪ Solid precipitate forming...';
      case ReactionEffectType.liquidMixing:
        return '🌊 Liquids mixing...';
      case ReactionEffectType.smokeEmission:
        return '💨 Smoke emitted...';
      case ReactionEffectType.heatGlow:
        return '🔥 Heat released...';
      case ReactionEffectType.flame:
        return '🔥 Flame produced...';
      case ReactionEffectType.spark:
        return '✨ Sparks emitted...';
    }
  }

  /// Get color for effect type
  static Color _getEffectColor(ReactionEffectType type) {
    switch (type) {
      case ReactionEffectType.colorChange:
        return Colors.purple;
      case ReactionEffectType.gasBubbles:
        return Colors.cyan;
      case ReactionEffectType.precipitate:
        return Colors.blue;
      case ReactionEffectType.liquidMixing:
        return Colors.teal;
      case ReactionEffectType.smokeEmission:
        return Colors.grey;
      case ReactionEffectType.heatGlow:
        return Colors.orange;
      case ReactionEffectType.flame:
        return Colors.red;
      case ReactionEffectType.spark:
        return Colors.yellow;
    }
  }

  /// Get reaction information
  static Map<String, dynamic> getReactionInfo(String reactionId) {
    final reactionMap = {
      'HCl_NaOH': {
        'equation': 'HCl + NaOH → NaCl + H₂O',
        'type': 'Neutralization',
        'productState': 'Colorless solution',
      },
      'AgNO3_NaCl': {
        'equation': 'AgNO₃ + NaCl → AgCl↓ + NaNO₃',
        'type': 'Precipitation',
        'productState': 'White precipitate',
      },
      'Mg_O2': {
        'equation': '2Mg + O₂ → 2MgO',
        'type': 'Combustion',
        'productState': 'White solid (MgO)',
      },
      'CaCO3_decomposition': {
        'equation': 'CaCO₃ → CaO + CO₂↑',
        'type': 'Thermal Decomposition',
        'productState': 'White solid + gas',
      },
      'Fe_CuSO4': {
        'equation': 'Fe + CuSO₄ → FeSO₄ + Cu',
        'type': 'Displacement',
        'productState': 'Brown copper deposit',
      },
    };

    return reactionMap[reactionId] ??
        {
          'equation': 'Unknown reaction',
          'type': 'Unknown',
          'productState': 'Unknown',
        };
  }
}