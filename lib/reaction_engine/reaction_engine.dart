import 'package:flutter/material.dart';

class ReactionEngine {
  static void simulateReaction(String reactionType, BuildContext context) {
    switch (reactionType) {
      case 'neutralization':
        _showNeutralizationEffect(context);
        break;
      case 'precipitation':
        _showPrecipitationEffect(context);
        break;
      case 'gas':
        _showGasEffect(context);
        break;
      default:
        break;
    }
  }

  static void _showNeutralizationEffect(BuildContext context) {
    // Show color change and mixing animation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Neutralization reaction: Color changes from acidic to neutral!')),
    );
  }

  static void _showPrecipitationEffect(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Precipitation: Solid particles form!')),
    );
  }

  static void _showGasEffect(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gas production: Bubbles appear!')),
    );
  }
}