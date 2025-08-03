// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class ImageGenerationService {
//   final Dio _dio = Dio();

//   /// Generates an AI image from Pollinations and saves it locally.
//   /// Returns the saved File if successful, or null if failed.
//   Future<File?> generateAndSaveImage(String prompt) async {
//     try {
//       // 1. Encode the prompt for URL usage
//       final encodedPrompt = Uri.encodeComponent(prompt);
//       final url = 'https://image.pollinations.ai/prompt/$encodedPrompt';

//       // 2. Decide the save location and file name
//       final dir = await getApplicationDocumentsDirectory();
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
//       final filePath = '${dir.path}/$fileName';

//       // 3. Download the image as bytes
//       final response = await _dio.get<List<int>>(
//         url,
//         options: Options(responseType: ResponseType.bytes),
//       );

//       // 4. Save to file
//       final file = File(filePath);
//       await file.writeAsBytes(response.data!);

//       return file;
//     } catch (e) {
//       print('Image generation failed: $e');
//       return null;
//     }
//   }
// }
