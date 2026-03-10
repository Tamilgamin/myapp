# AR Chemistry Lab

A complete Augmented Reality Chemistry Laboratory mobile application built with Flutter.

## Features

- AR experiments using ARCore (Android) and ARKit (iOS)
- 50+ chemistry experiments
- AI Chemistry Teacher powered by Gemini API
- Leaderboard and scoring system
- Offline support
- AdMob monetization
- Sound effects and haptic feedback

## Setup

1. Install Flutter: https://flutter.dev/docs/get-started/install

2. Clone or download the project.

3. Run `flutter pub get` to install dependencies.

4. For Firebase:
   - Create a Firebase project
   - Add Android and iOS apps
   - Download google-services.json and place in android/app/
   - Download GoogleService-Info.plist and place in ios/Runner/

5. For AdMob:
   - Create AdMob account
   - Replace test ad unit IDs with your own

6. For Gemini API:
   - Get API key from Google AI Studio
   - Replace placeholder in AI assistant with actual API call

7. Run `flutter run` to build and run the app.

## Project Structure

- lib/
  - components/ - Reusable UI components
  - screens/ - App screens
  - ar_engine/ - AR functionality
  - reaction_engine/ - Reaction simulations
  - experiment_database/ - Experiment data
  - ai_assistant/ - AI chat functionality
  - services/ - App services (state, ads, etc.)
  - ads/ - AdMob integration

- assets/
  - experiments.json - Experiment data
  - sounds/ - Sound effects
  - models/ - 3D models for AR

## Building

- Android: `flutter build apk`
- iOS: `flutter build ios` (requires macOS)

## Requirements

- Flutter 3.9+
- Android API 24+ or iOS 12+
- ARCore compatible device for Android
- ARKit compatible device for iOS

## License

This project is for educational purposes.
# example of installing via sdkmanager (after downloading the cmdline-tools)
mkdir -p ~/Android/Sdk/cmdline-tools
cd ~/Android/Sdk/cmdline-tools
# download and unzip latest command-line-tools from https://developer.android.com/studio#command-tools
unzip ~/Downloads/commandlinetools-linux-*.zip

# then install platforms/build-tools
yes | ~/Android/Sdk/cmdline-tools/bin/sdkmanager --sdk_root=${HOME}/Android/Sdk "platform-tools" "platforms;android-33" "build-tools;33.0.2"