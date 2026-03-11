import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class AudioVibrationService {
  static final AudioVibrationService _instance = AudioVibrationService._internal();

  late AudioPlayer _audioPlayer;

  AudioVibrationService._internal() {
    _audioPlayer = AudioPlayer();
  }

  factory AudioVibrationService() {
    return _instance;
  }

  // Vibration effects
  Future<void> lightVibration() async {
    await Vibration.vibrate(duration: 50);
  }

  Future<void> mediumVibration() async {
    await Vibration.vibrate(duration: 100);
  }

  Future<void> heavyVibration() async {
    await Vibration.vibrate(duration: 200);
  }

  Future<void> vibratePattern() async {
    await Vibration.vibrate(pattern: [0, 100, 50, 100]);
  }

  // Sound effects
  Future<void> playBubbleSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/bubble.mp3'));
    } catch (e) {
      print('Error playing bubble sound: $e');
    }
  }

  Future<void> playFlameSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/flame.mp3'));
    } catch (e) {
      print('Error playing flame sound: $e');
    }
  }

  Future<void> playGlassSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/glass.mp3'));
    } catch (e) {
      print('Error playing glass sound: $e');
    }
  }

  Future<void> playLiquidPourSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/liquid_pour.mp3'));
    } catch (e) {
      print('Error playing liquid pour sound: $e');
    }
  }

  Future<void> playSuccessSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/success.mp3'));
    } catch (e) {
      print('Error playing success sound: $e');
    }
  }

  Future<void> playErrorSound() async {
    try {
      await _audioPlayer.play(AssetSource('sounds/error.mp3'));
    } catch (e) {
      print('Error playing error sound: $e');
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
