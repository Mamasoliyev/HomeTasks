import 'package:flutter/material.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/models/banner_model.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/models/book_model.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/models/category_model.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/models/sub_category_model.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/services/data_service.dart';

class BannerProvider extends ChangeNotifier {
  final DataService dataService;

  BannerProvider({required this.dataService});

  List<BannerModel> _banners = [];
  List<CategoryModel> _categories = [];
  List<SubCategoryModel> _subCategories = [];
  List<BookModel> _books = [];
  List<BookModel> get books => _books;

  List<SubCategoryModel> get subCategories => _subCategories;
  bool _isLoading = false;
  String? _error;

  List<BannerModel> get banners => _banners;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _banners = await dataService.getBanners();
      _categories = await dataService.fetchCategories();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
   Future<void> loadSubCategories(int categoryId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _subCategories = await dataService.fetchSubCategories(categoryId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadBooks(
    // int? categoryId, int? subCategoryId
    ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _books = await dataService.fetchBooks(
        // categoryId: categoryId,
        // subCategoryId: subCategoryId,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
