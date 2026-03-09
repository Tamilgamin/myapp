class AppConstants {
  // App info
  static const String appName = 'AR Chemistry Lab';
  static const String appVersion = '1.0.0';
  
  // Equipment types
  static const List<String> equipmentTypes = [
    'beaker',
    'test_tube',
    'conical_flask',
    'burette',
    'pipette',
    'glass_rod',
    'funnel',
    'bunsen_burner',
    'evaporating_dish',
    'measuring_cylinder',
    'tripod_stand',
    'wire_gauze',
    'test_tube_holder',
    'reagent_bottle',
  ];

  // Reaction types
  static const List<String> reactionTypes = [
    'color_change',
    'bubbles',
    'precipitate',
    'smoke',
    'flame',
    'heat_glow',
    'liquid_mixing',
  ];

  // Experiment categories
  static const List<String> categories = [
    'Acid-Base Reactions',
    'Redox Reactions',
    'Precipitations',
    'Gas Production',
    'Combustion',
    'Thermal Reactions',
    'Oxidation-Reduction',
    'Crystallization',
    'Polymerization',
    'Organic Chemistry',
  ];

  // Difficulty levels
  static const int difficultyEasy = 1;
  static const int difficultyMedium = 2;
  static const int difficultyHard = 3;
  static const int difficultyVeryHard = 4;
  static const int difficultyExtreme = 5;

  // Rewards
  static const int rewardEasyExperiment = 10;
  static const int rewardMediumExperiment = 25;
  static const int rewardHardExperiment = 50;
  static const int rewardVeryHardExperiment = 100;
  static const int rewardExtremeExperiment = 200;

  static const int rewardQuizPerfect = 50;
  static const int rewardQuizGood = 25;
  static const int rewardQuizPassed = 10;

  // Level thresholds
  static const int level1Threshold = 0;
  static const int level2Threshold = 500;
  static const int level3Threshold = 1500;
  static const int level4Threshold = 3000;
  static const int level5Threshold = 5000;
  static const int level6Threshold = 10000;

  // AdMob IDs (Replace with your own)
  static const String admobBannerId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyyyy';
  static const String admobInterstitialId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyyyy';
  static const String admobRewardedId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyyyy';

  // Firebase collections
  static const String firebaseUsersCollection = 'users';
  static const String firebaseProgressCollection = 'progress';
  static const String firebaseAnalyticsCollection = 'analytics';

  // Shared preferences keys
  static const String spKeyToken = 'auth_token';
  static const String spKeyUserId = 'user_id';
  static const String spKeyUsername = 'username';
  static const String spKeyScore = 'score';
  static const String spKeyCompletedExperiments = 'completed_experiments';
  static const String spKeySoundEnabled = 'sound_enabled';
  static const String spKeyVibrationEnabled = 'vibration_enabled';
  static const String spKeyLastActivity = 'last_activity';
}
