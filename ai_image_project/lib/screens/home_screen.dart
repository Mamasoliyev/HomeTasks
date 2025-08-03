import 'package:ai_image_project/helpers/permission_handler.dart';
import 'package:ai_image_project/helpers/toast_helper.dart';
import 'package:ai_image_project/screens/gallery_screen.dart';
import 'package:ai_image_project/screens/generated_gollorey_screen.dart';
import 'package:ai_image_project/services/auth_service.dart';
import 'package:ai_image_project/viewmodel/ai_auth_provider.dart';
import 'package:ai_image_project/viewmodel/ai_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions(skipIfExists: true);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorScheme.background,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDF2FB), Color(0xFFD2E3FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async {
                    await context.read<AiAuthProvider>().logOut();
                  },
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
            // App Bar (custom)
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: colorScheme.primary.withOpacity(0.07),
                  child: const Icon(
                    Icons.image,
                    size: 36,
                    color: Color(0xFF185ADB),
                  ),
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI Image Generator",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Turn your ideas into stunning images.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 36),

            // Prompt input card (no functionality)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
              color: Colors.white.withOpacity(0.90),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Describe your dream image",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            maxLines: 3,
                            onChanged: (value) {
                              context.read<AiImageProvider>().setIsNotEmpty(
                                value.isNotEmpty,
                              );
                            },
                            controller: context
                                .read<AiImageProvider>()
                                .textPrompt,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  "e.g. A fantasy landscape with purple trees",
                            ),
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Consumer<AiImageProvider>(
                      builder: (context, value, child) {
                        return SizedBox(
                          width: double.infinity,
                          child: value.isLoading
                              ? Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : ElevatedButton.icon(
                                  onPressed: !value.isNotEmpty
                                      ? null
                                      : () async {
                                          await value.generateImage();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    backgroundColor: const Color(0xFF185ADB),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.flash_on,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    "Generate Image",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Gallery preview card (no images yet)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryScreen()),
                );
              },
              child: Text(
                "Your Gallery",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.90),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.13),
                    spreadRadius: 1,
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Consumer<AiImageProvider>(
                    builder: (context, value, child) {
                      if (value.generatedImage != null) {
                        return SizedBox(
                          height: 200,
                          width: 200,

                          child: Image.file(
                            value.generatedImage!,
                            fit: BoxFit.cover,
                          ),
                        );
                      } else {
                        ToastHelper.showSuccess(
                          "Your image generated successfully",
                        );
                        return Icon(
                          Icons.photo_library_outlined,
                          color: Colors.grey[400],
                          size: 46,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 5),
                  const Text(
                    "Your generated images will appear here.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()), // Push content up
            // Footer / App version
            Center(
              child: Text(
                "© 2025 AI Image Generator",
                style: TextStyle(color: Colors.grey[400], fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
