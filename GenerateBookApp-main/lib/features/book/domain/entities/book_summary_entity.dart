import 'package:ai_book_summary_app/core/app/typdefs/typedefs.dart';

class BookSummaryEntity {
  final String? summary;
  final int? rating;
  final String? author;
  final String? title;

  BookSummaryEntity({this.summary, this.rating, this.author, this.title});
}
