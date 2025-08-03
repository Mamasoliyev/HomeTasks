class GenerationModel {
  final String userInput;
  final String poem;
  final String imagePrompt;

  GenerationModel({
    required this.userInput,
    required this.poem,
    required this.imagePrompt,
  });

  factory GenerationModel.fromJson(Map<String, dynamic> json) {
    return GenerationModel(
      userInput: json['userInput'] as String,
      poem: json['poem'] as String,
      imagePrompt: json['imagePrompt'] as String,
    );
  }

  factory GenerationModel.fromMap(Map<String, String> map) {
    return GenerationModel(
      userInput: map['userInput'] ?? '',
      poem: map['poem'] ?? '',
      imagePrompt: map['imagePrompt'] ?? '',
    );
  }
}
