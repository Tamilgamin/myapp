import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  late FirebaseFirestore _firestore;

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal() {
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> logExperimentStart(int experimentId, String experimentTitle) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'experiment_start',
        'experimentId': experimentId,
        'experimentTitle': experimentTitle,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging experiment start: $e');
    }
  }

  Future<void> logExperimentComplete(int experimentId, int timeSpentSeconds) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'experiment_complete',
        'experimentId': experimentId,
        'timeSpent': timeSpentSeconds,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging experiment complete: $e');
    }
  }

  Future<void> logQuizAttempt(int experimentId, int score, int totalQuestions) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'quiz_attempt',
        'experimentId': experimentId,
        'score': score,
        'totalQuestions': totalQuestions,
        'percentage': (score / totalQuestions * 100).toStringAsFixed(2),
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging quiz attempt: $e');
    }
  }

  Future<void> logAIQuery(String question) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'ai_query',
        'question': question,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging AI query: $e');
    }
  }

  Future<void> logARView(int experimentId) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'ar_view',
        'experimentId': experimentId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging AR view: $e');
    }
  }

  Future<void> logError(String errorMessage) async {
    try {
      await _firestore.collection('analytics').add({
        'event': 'error',
        'message': errorMessage,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error logging error: $e');
    }
  }
}
