import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xarita_map_ai/services/Poem_provider.dart';

class PoemScreen extends StatefulWidget {
  final String initialContent;

  const PoemScreen({Key? key, required this.initialContent}) : super(key: key);

  @override
  _PoemScreenState createState() => _PoemScreenState();
}

class _PoemScreenState extends State<PoemScreen> {
  @override
  void initState() {
    super.initState();
    // Build tugagach providerni chaqirish:
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PoemProvider>(context, listen: false);
      provider.generatePoemAndImage(widget.initialContent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('O‘zbekcha She’r Generatori')),
      body: Consumer<PoemProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.isLoading)
                    Center(child: CircularProgressIndicator()),
                  if (provider.error != null)
                    Text('Xato: ${provider.error}',
                        style: TextStyle(color: Colors.red)),
                  if (provider.poemResponse != null) ...[
                    Text(
                         'Matn: ${widget.initialContent}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    Text('She’r:\n${provider.poemResponse!.poem}',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 16),
                    // Text('Image Prompt:\n${provider.poemResponse!.imagePrompt}',
                    //     style: TextStyle(fontSize: 14)),
                  ],
                  if (provider.imageUrl != null) ...[
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 320,
                      color: Colors.grey,
                      child: Image.network(provider.imageUrl!)),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
