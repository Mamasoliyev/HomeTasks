// import 'dart:developer';

// import 'package:get/get.dart';

// import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
// import 'package:ai_book_summary_app/features/book/domain/usecases/get_book_summary_usecase.dart';

// class BookController extends GetxController {
//   RxBool isLoading = false.obs;
//   RxList<BookSummaryEntity> summaries = <BookSummaryEntity>[].obs;

//   GetBookSummaryUsecase getBookSummaryUsecase;
//   BookController({required this.getBookSummaryUsecase});

//   Future<BookSummaryEntity?> getBookSummary({
//     required String author,
//     required String book,
//   }) async {
//     isLoading.value = true;
//     final result = await getBookSummaryUsecase(
//       params: GetBookSummaryUsecaseParams(author: author, book: book),
//     );

//     result.fold(
//       (l) {
//         log(l.message);
//       },
//       (r) {
//         summaries.add(r);
//         return r;
//       },
//     );
//     isLoading.value = false;
//   }
// }

import 'dart:developer';

import 'package:ai_book_summary_app/features/book/data/mappers/book_mapper.dart';
import 'package:ai_book_summary_app/features/book/data/models/book_summary_model.dart';
import 'package:ai_book_summary_app/features/book/data/storage/book_storage.dart';
import 'package:ai_book_summary_app/features/book/domain/entities/book_summary_entity.dart';
import 'package:ai_book_summary_app/features/book/domain/usecases/get_book_summary_usecase.dart';
import 'package:get/get.dart';

class BookController extends GetxController {
  final GetBookSummaryUsecase getBookSummaryUsecase;
  final BookStorageService _storageService;

  RxBool isLoading = false.obs;
  RxList<BookSummaryEntity> summaries = <BookSummaryEntity>[].obs;

  BookController({
    required this.getBookSummaryUsecase,
    required BookStorageService storageService,
  }) : _storageService = storageService;

  @override
  void onInit() {
    super.onInit();
    _loadSummaries();
  }

  void _loadSummaries() {
    final raw = _storageService.loadSummaries();
    log(
      '------------------Loaded summaries count: ${raw.length}------------------------',
    );
    summaries.assignAll(
      raw.map((json) => BookSummaryModel.fromJson(json).toEntity()),
    );
  }

  Future<void> getBookSummary({
    required String author,
    required String book,
  }) async {
    isLoading.value = true;
    final result = await getBookSummaryUsecase(
      params: GetBookSummaryUsecaseParams(author: author, book: book),
    );

    result.fold((failure) => log(failure.message), (entity) async {
      summaries.add(entity);
      await _saveSummaries();
    });

    isLoading.value = false;
  }

  Future<void> _saveSummaries() async {
    // Map Entity list to Model list, then to JSON list
    final jsonList = summaries
        .map((entity) => BookSummaryModel.fromEntity(entity).toJson())
        .toList();
    await _storageService.saveSummaries(jsonList);
  }

  Future<void> deleteSummary(BookSummaryEntity entity) async {
    summaries.remove(entity);
    await _saveSummaries();
  }

  Future<void> clearAll() async {
    summaries.clear();
    await _storageService.clearAll();
  }
}
