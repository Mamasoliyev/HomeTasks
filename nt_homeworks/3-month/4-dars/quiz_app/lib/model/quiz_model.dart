import 'package:quiz_app/model/question_model.dart';

class QuizModel {
  final String? category;
  final String? categoryImage;
  final List<QuestionModel?>? questions;
  QuizModel({required this.category, required this.categoryImage, required this.questions});
  

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      category: json['category'],
      categoryImage: json['category_image'],
      questions: json['questions'].map
    );
  }

}
// {
//     "category": "HTML",
//     "category_image":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQEc9A_S6BPxCDRp5WjMFEfXrpCu1ya2OO-Lw&s",
//     "questions": [
//       {
//         "title": "Who is making the Web standards?",
//         "id": 1,
//         "answers": [
//           "The World Wide Web Consortium",
//           "Microsoft",
//           "Mozilla",
//           "Google",
//         ],
//         "correct_answer": "The World Wide Web Consortium",
//       },