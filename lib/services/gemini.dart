import 'package:clone_ai/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getGeminiResponse(String question) async {
  final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$geminiKey");

  final requestBody = jsonEncode({
    "contents": [
      {
        "parts": [
          {"text": question}
        ]
      }
    ]
  });

  final response = await http.post(url, body: requestBody, headers: {
    'Content-Type': 'application/json',
  });

  if (response.statusCode == 200) {
    // print('Response body: ${response.body}');
    final data = jsonDecode(response.body);

    if (data['candidates'] != null &&
        data['candidates'].isNotEmpty &&
        data['candidates'][0]['content'] != null &&
        data['candidates'][0]['content']['parts'] != null &&
        data['candidates'][0]['content']['parts'].isNotEmpty) {
      final generatedContent = data['candidates'][0]['content']['parts'][0]['text'];
      return generatedContent;
    } else {
      throw Exception('Unexpected response structure: ${response.body}');
    }
  } else {
    throw Exception('Failed to generate text: ${response.statusCode} - ${response.body}');
  }
}
