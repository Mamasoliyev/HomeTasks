import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_summary_model.freezed.dart';
part 'book_summary_model.g.dart';

@freezed
abstract class BookSummaryModel with _$BookSummaryModel {
  const factory BookSummaryModel({
    String? summary,
    int? rating,
    String? author,
    String? title,
  }) = _BookSummaryModel;

  factory BookSummaryModel.fromEntity(BookSummaryEntity entity) {
    return BookSummaryModel(
      summary: entity.summary,
      rating: entity.rating,
      author: entity.author,
      title: entity.title,
    );
  }

  factory BookSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$BookSummaryModelFromJson(json);
}
