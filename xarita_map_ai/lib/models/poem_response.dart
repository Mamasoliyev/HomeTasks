class PoemResponse {
  final String poem;
  final String imagePrompt;

  PoemResponse({required this.poem, required this.imagePrompt});

  factory PoemResponse.fromJson(Map<String, String> json) {
    return PoemResponse(
      poem: json['poem'] ?? 'She’r topilmadi',
      imagePrompt: json['prompt'] ?? 'Prompt topilmadi',
    );
  }
}