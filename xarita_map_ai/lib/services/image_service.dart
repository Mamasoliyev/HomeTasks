// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class ImageService {
//   final String _apiKey = 'sk-...'; // <-- Sizning OpenAI API kalitingiz

//   Future<String> generateImage(String prompt) async {
//     final url = Uri.parse('https://api.openai.com/v1/images/generations');

//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $_apiKey',
//       },
//       body: jsonEncode({
//         "model": "dall-e-3", // yoki dall-e-2
//         "prompt": prompt,
//         "n": 1,
//         "size": "1024x1024"
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['data'][0]['url'];
//     } else {
//       throw Exception('Image API error: ${response.body}');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

class ImageService {
  Future<String> generateImage(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/images/generations');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "dall-e-3",
        "prompt": prompt,
        "n": 1,
        "size": "1024x1024",
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'][0]['url'];
    } else {
      throw Exception('Image API error: ${response.body}');
    }
  }
}
