import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();

  factory AudioService() {
    return _instance;
  }

  AudioService._internal() {
    _audioPlayer = AudioPlayer();
    _tts = FlutterTts();
    _initTTS();
  }

  late AudioPlayer _audioPlayer;
  late FlutterTts _tts;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  void _initTTS() {
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.5);
    _tts.setVolume(1.0);
    _tts.setPitch(1.0);
  }

  Future<void> playSound(String soundName) async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sounds/$soundName.wav'));
    } catch (e) {
      print('Error playing sound: $e');
    }
  }

  Future<void> playSoundUrl(String url) async {
    if (!_soundEnabled) return;
    
    try {
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      print('Error playing sound from URL: $e');
    }
  }

  Future<void> speak(String text) async {
    try {
      await _tts.speak(text);
    } catch (e) {
      print('Error speaking: $e');
    }
  }

  Future<void> stopSpeech() async {
    await _tts.stop();
  }

  Future<void> vibrate({int duration = 100}) async {
    if (!_vibrationEnabled) return;
    
    if (await Vibration.hasVibrator() ?? false) {
      await Vibration.vibrate(duration: duration);
    }
  }

  Future<void> vibratePattern(List<int> pattern) async {
    if (!_vibrationEnabled) return;
    
    if (await Vibration.hasVibrator() ?? false) {
      await Vibration.vibrate(pattern: pattern);
    }
  }

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  void setVibrationEnabled(bool enabled) {
    _vibrationEnabled = enabled;
  }

  Future<void> stopAllAudio() async {
    await _audioPlayer.stop();
    await stopSpeech();
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
    await _tts.stop();
  }
}
