// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key});

//   @override
//   State<GalleryScreen> createState() => _GalleryScreenState();
// }

// class _GalleryScreenState extends State<GalleryScreen> {
//   List<File> _imageFiles = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadImages();
//   }

//   Future<void> _loadImages() async {
//     final dir = await getApplicationDocumentsDirectory();
//     final files = dir.listSync();
//     final imageFiles = files
//         .where(
//           (f) =>
//               f is File &&
//               (f.path.endsWith('.png') ||
//                   f.path.endsWith('.jpg') ||
//                   f.path.endsWith('.jpeg')),
//         )
//         .map((f) => File(f.path))
//         .toList();
//     setState(() {
//       _imageFiles = imageFiles.reversed.toList(); // Show latest first
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Your Gallery'),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black87,
//       ),
//       backgroundColor: const Color(0xFFF8FAFC),
//       body: Padding(
//         padding: const EdgeInsets.all(14.0),
//         child: _imageFiles.isEmpty
//             ? Center(
//                 child: Text(
//                   "No images found.\nGenerate your first AI image!",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey[500], fontSize: 17),
//                 ),
//               )
//             : GridView.builder(
//                 itemCount: _imageFiles.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 18,
//                   crossAxisSpacing: 18,
//                   childAspectRatio: 0.88,
//                 ),
//                 itemBuilder: (context, index) {
//                   final file = _imageFiles[index];
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(18),
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         Image.file(file, fit: BoxFit.cover),
//                         Positioned(
//                           right: 8,
//                           top: 8,
//                           child: Icon(
//                             Icons.image,
//                             color: Colors.white70,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }
