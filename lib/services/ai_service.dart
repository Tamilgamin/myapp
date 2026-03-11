import 'package:http/http.dart' as http;
import 'dart:convert';

class AIService {
  static final AIService _instance = AIService._internal();

  factory AIService() {
    return _instance;
  }

  AIService._internal();

  /// Replace with your actual Gemini API key
  static const String _apiKey = 'YOUR_GEMINI_API_KEY';
  static const String _apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  final List<Map<String, String>> _conversationHistory = [];

  Future<String> askQuestion(String question) async {
    try {
      _conversationHistory.add({'role': 'user', 'content': question});

      final response = await http.post(
        Uri.parse('$_apiUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'contents': [
            {
              'parts': [
                {'text': '${_buildSystemPrompt()}\n\nQuestion: $question'}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 1024,
          }
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final answer = jsonResponse['candidates'][0]['content']['parts'][0]['text'];
        
        _conversationHistory.add({'role': 'assistant', 'content': answer});
        return answer;
      } else {
        throw Exception('Failed to get response from AI: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calling AI service: $e');
      return 'Sorry, I encountered an error. Please try again.';
    }
  }

  String _buildSystemPrompt() {
    return '''You are an expert chemistry teacher helping students learn chemistry through AR experiments. You are knowledgeable about:
- Chemical reactions and mechanisms
- Laboratory safety
- Equipment usage
- Chemical properties and behaviors
- Practical experiment procedures

Provide clear, educational explanations that are appropriate for high school students. 
Focus on helping students understand concepts and safety.
Keep responses concise but informative.''';
  }

  void clearHistory() {
    _conversationHistory.clear();
  }

  List<Map<String, String>> get conversationHistory => _conversationHistory;
}
