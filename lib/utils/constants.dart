class AppConstants {
  // App information
  static const String appName = 'AR Chemistry Lab';
  static const String appVersion = '1.0.0';

  // Spacings
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Border radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;

  // Icon sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;

  // Text styles
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeLarge = 16.0;
  static const double fontSizeXLarge = 18.0;
  static const double fontSizeTitle = 24.0;
  static const double fontSizeHeading = 32.0;

  // Animation durations
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 400);
  static const Duration animationDurationLong = Duration(milliseconds: 800);

  // Experiment difficulty levels
  static const int difficultyEasy = 1;
  static const int difficultyMedium = 2;
  static const int difficultyHard = 3;
  static const int difficultyVeryHard = 4;
  static const int difficultyExpert = 5;

  // Points and scoring
  static const int pointsPerExperiment = 10;
  static const int pointsPerQuizQuestion = 5;
  static const int pointsPerCorrectAnswer = 5;
  static const int bonusPointsForCompletion = 20;

  // Firebase collections
  static const String firebaseUsersCollection = 'users';
  static const String firebaseScoresCollection = 'scores';
  static const String firebaseAnalyticsCollection = 'analytics';
  static const String firebaseLeaderboardCollection = 'leaderboard';
}

class ReactionTypes {
  static const String neutralization = 'neutralization';
  static const String precipitation = 'precipitation';
  static const String gas = 'gas';
  static const String combustion = 'combustion';
  static const String oxidation = 'oxidation';
  static const String decomposition = 'decomposition';
  static const String synthesis = 'synthesis';
  static const String displacement = 'displacement';
}

class EquipmentTypes {
  static const String container = 'container';
  static const String heating = 'heating';
  static const String measuring = 'measuring';
  static const String mixing = 'mixing';
  static const String holding = 'holding';
}

class AnimationTypes {
  static const String pour = 'pour';
  static const String burn = 'burn';
  static const String mix = 'mix';
  static const String heat = 'heat';
  static const String bubble = 'bubble';
  static const String smoke = 'smoke';
}
