class AppConstants {
  // API Keys and Configuration
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY';
  static const String adMobAndroidBannerId = 'ca-app-pub-xxxxxxxxxxxxxxxx/yyyyyyyyyyyy';
  static const String adMobAndroidInterstitialId = 'ca-app-pub-xxxxxxxxxxxxxxxx/zzzzzzzzzzzz';
  static const String adMobAndroidRewardedId = 'ca-app-pub-xxxxxxxxxxxxxxxx/wwwwwwwwwwww';

  // Firebase Configuration
  static const String firebaseProjectId = 'ar-chemistry-lab';

  // App Configuration
  static const String appName = 'AR Chemistry Lab';
  static const String appVersion = '1.0.0';
  static const int minAndroidVersion = 24;
  static const int minIosVersion = 12;

  // Quiz Configuration
  static const int pointsPerQuestion = 20;
  static const int passingScore = 70;

  // Experiment Configuration
  static const int totalExperiments = 100;
  static const int maxFavorites = 50;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 300);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  static const Duration animationDurationLong = Duration(milliseconds: 800);

  // Spacing/Padding
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Border Radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;

  // Font Sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 14.0;
  static const double fontSizeHeading = 16.0;
  static const double fontSizeXLarge = 20.0;

  // Icon Sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Text Constants
  static const String welcomeMessage = 'Welcome to AR Chemistry Lab!';
  static const String loadingMessage = 'Loading experiments...';
  static const String errorMessage = 'Something went wrong. Please try again.';
  static const String noInternetMessage = 'No internet connection';
}

class RegexPatterns {
  static final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final phonePattern = RegExp(r'^\+?1?\d{9,15}$');
  static final passwordPattern = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
}
