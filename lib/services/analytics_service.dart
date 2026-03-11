import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> logExperimentStarted(int experimentId, String title) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'experiment_started',
        'experimentId': experimentId,
        'title': title,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging experiment started: $e');
    }
  }

  Future<void> logExperimentCompleted(
    int experimentId,
    String title,
    int points,
    Duration duration,
  ) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'experiment_completed',
        'experimentId': experimentId,
        'title': title,
        'points': points,
        'durationSeconds': duration.inSeconds,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging experiment completed: $e');
    }
  }

  Future<void> logQuizCompleted(
    int experimentId,
    int score,
    int totalQuestions,
  ) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'quiz_completed',
        'experimentId': experimentId,
        'score': score,
        'totalQuestions': totalQuestions,
        'percentage': (score / totalQuestions * 100).toStringAsFixed(1),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging quiz completed: $e');
    }
  }

  Future<void> logARSessionStarted() async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'ar_session_started',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging AR session started: $e');
    }
  }

  Future<void> logARSessionEnded(Duration duration) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'ar_session_ended',
        'durationSeconds': duration.inSeconds,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging AR session ended: $e');
    }
  }

  Future<void> logAIAssistantQuery(String query) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'ai_assistant_query',
        'query': query,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging AI assistant query: $e');
    }
  }

  Future<void> logAdShown(String adType) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'ad_shown',
        'adType': adType,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging ad shown: $e');
    }
  }
}
