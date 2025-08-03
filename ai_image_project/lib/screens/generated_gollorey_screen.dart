import 'package:ai_image_project/screens/image_seen_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai_image_project/services/auth_service.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 234, 246),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My AI Images",
          style: TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: AuthService().getUserImages(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "Hech qanday rasm yuklanmagan",
                style: TextStyle(color: Colors.deepPurple),
              ),
            );
          }

          final images = snapshot.data;

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: images?.length ?? 10,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisExtent: 210,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final image = images?[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageSeenScreen(slextedImage: index),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        image?['imageUrl'] ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),

                    Text(
                      maxLines: 1,
                      image?['promt'],
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    // Text(
                    //   image?['promt'] ?? 'No prompt',
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
