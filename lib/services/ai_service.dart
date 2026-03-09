import 'package:http/http.dart' as http;
import 'dart:convert';

class AIService {
  static final AIService _instance = AIService._internal();
  late String _apiKey;
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  factory AIService({String? apiKey}) {
    if (apiKey != null) {
      _instance._apiKey = apiKey;
    }
    return _instance;
  }

  AIService._internal();

  void setApiKey(String apiKey) {
    _apiKey = apiKey;
  }

  Future<String> askQuestion(String question) async {
    try {
      if (_apiKey.isEmpty) {
        return 'AI service not configured. Please add your Gemini API key in settings.';
      }

      final response = await http.post(
        Uri.parse('$_baseUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': _buildChemistryPrompt(question)}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'topK': 40,
            'topP': 0.95,
            'maxOutputTokens': 2048,
          },
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        return text;
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error communicating with AI: $e';
    }
  }

  String _buildChemistryPrompt(String question) {
    return '''You are an expert chemistry teacher helping students learn through AR Chemistry Lab.
    
Student Question: $question

Please provide:
1. A clear, concise explanation suitable for students
2. Examples if relevant
3. Safety considerations if applicable
4. Tips for hands-on experiments

Keep your response educational and encouraging.''';
  }

  Future<String> explainExperiment(String experimentTitle, String reactionEquation) async {
    final question = 'Explain the chemistry of the experiment: $experimentTitle. The reaction equation is: $reactionEquation. What should I observe during this reaction?';
    return askQuestion(question);
  }

  Future<String> getExperimentTips(String experimentTitle) async {
    final question = 'What are practical tips and safety precautions for performing the $experimentTitle experiment?';
    return askQuestion(question);
  }
}
