import 'dart:convert';
import 'package:http/http.dart' as http;

class GPTService {
  final String _apiKey =
      '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';

  Future<Map<String, String>> generatePoemAndPrompt(String userInput) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "temperature": 0.8,
        "messages": [
          {
            "role": "system",
            "content":
                "You are an assistant that generates poems and image prompts. When a user gives a sentence, return a short nostalgic Uzbek poem and an English image prompt.",
          },
          {
            "role": "user",
            "content":
                "$userInput\nReturn:\n\nShe’r:\n...\n\nImage Prompt:\n...",
          },
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'] as String? ?? '';

      final poemMatch = RegExp(
        r'She’r:\s*(.+?)\n\n',
        dotAll: true,
      ).firstMatch(content);
      final promptMatch = RegExp(
        r'Image Prompt:\s*(.+)',
        dotAll: true,
      ).firstMatch(content);

      return {
        'poem': poemMatch?.group(1)?.trim() ?? 'Not found',
        'prompt': promptMatch?.group(1)?.trim() ?? 'Not found',
      };
    } else {
      throw Exception('GPT API error: ${response.body}');
    }
  }
}
