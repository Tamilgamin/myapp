import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  late AudioPlayer _audioPlayer;
  late bool _soundEnabled = true;
  late bool _vibrationEnabled = true;

  factory AudioService() {
    return _instance;
  }

  AudioService._internal() {
    _audioPlayer = AudioPlayer();
  }

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  void setVibrationEnabled(bool enabled) {
    _vibrationEnabled = enabled;
  }

  bool get soundEnabled => _soundEnabled;
  bool get vibrationEnabled => _vibrationEnabled;

  Future<void> playSound(String soundFile) async {
    if (_soundEnabled) {
      try {
        await _audioPlayer.play(AssetSource('sounds/$soundFile.mp3'));
      } catch (e) {
        print('Error playing sound: $e');
      }
    }
  }

  Future<void> playBubbleSound() => playSound('bubble');
  Future<void> playPourSound() => playSound('pour');
  Future<void> playFlameSound() => playSound('flame');
  Future<void> playGlassSound() => playSound('glass');
  Future<void> playMixSound() => playSound('mix');
  Future<void> playSuccessSound() => playSound('success');
  Future<void> playFailSound() => playSound('fail');

  Future<void> vibrate({int durationMs = 500}) async {
    if (_vibrationEnabled) {
      if (await Vibration.hasVibrator() ?? false) {
        await Vibration.vibrate(duration: durationMs);
      }
    }
  }

  Future<void> vibrateFeedback() => vibrate(durationMs: 200);

  Future<void> vibrateSuccess() async {
    if (_vibrationEnabled) {
      if (await Vibration.hasVibrator() ?? false) {
        await Vibration.vibrate(pattern: [0, 100, 100, 100]);
      }
    }
  }

  Future<void> vibrateError() async {
    if (_vibrationEnabled) {
      if (await Vibration.hasVibrator() ?? false) {
        await Vibration.vibrate(pattern: [0, 200, 100, 200]);
      }
    }
  }

  Future<void> stop() => _audioPlayer.stop();
}
