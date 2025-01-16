import 'package:clone_ai/consts/consts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getChatGPTResponse(String question) async {
  const String apiKey = chatGptKey; // Replace with your valid API key
  const String baseUrl = "https://api.openai.com/v1/chat/completions";

  final headers = {
    'Authorization': 'Bearer $apiKey',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    "model": "gpt-4o-mini", // Use the free-tier supported model
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": question}
    ],
    "max_tokens": 100,
    "temperature": 0.7,
  });

  try {
    final response = await http.post(Uri.parse(baseUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].trim();
    } else {
      final error = jsonDecode(response.body);
      throw Exception('Error: ${error['error']['message']}');
    }
  } catch (e) {
    throw Exception('Error fetching ChatGPT response: $e');
  }
}
