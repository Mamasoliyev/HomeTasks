
import 'package:kitobzor_app/core/network/dio_client.dart';
import 'package:kitobzor_app/core/network/token_storage.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/models/book_model.dart';
import 'package:kitobzor_app/feautures/kitobzor_data/models/sub_category_model.dart';
import 'package:kitobzor_app/injection_container.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';

class DataService {
  final DioClient dioClient;

  DataService(this.dioClient);

  Future<List<BannerModel>> getBanners({
    int limit = 11,
    int offset = 11,
  }) async {
    // save tokens with TokenStorage
    await sl<TokenStorage>().saveTokens();
    final response = await dioClient.dio.get(
      '/base/banners/',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    if (response.statusCode == 200) {
      final data = response.data['result'] as List;
      return data.map((e) => BannerModel.fromJson(e)).toList();
    } else {
      throw Exception('Bannerlarni yuklab bo‘lmadi');
    }
  }

  Future<List<CategoryModel>> fetchCategories({
    int limit = 111,
    int offset = 111,
  }) async {
    // log('${sl<TokenStorage>().getAccessToken()}');
    final response = await dioClient.dio.get(
      '/book/categories/',
      queryParameters: {'limit': limit, 'offset': offset},
    );

    if (response.statusCode == 200) {
      final data = response.data['result'] as List;
      return data.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw Exception('Kategoriyalarni yuklab bo‘lmadi');
    }
  }
  Future<List<SubCategoryModel>> fetchSubCategories(int categoryId) async {
    final response = await dioClient.dio.get(
      '/book/subcategories/',
      queryParameters: {
        'category': categoryId,
        'limit': 50, // ko‘proq chiqarish uchun
        'offset': 0,
      },
    );

    // log("MESSAGE: ${response.data}");
    // log("MESSAGE: ${response.statusCode}");

    if (response.statusCode == 200) {
      final data = response.data['result'];
      // log('Subkategoriyalar: $data');
      if (data.isEmpty) {
        // log('Subkategoriyalar topilmadi');
        return [];
      }
      // log('Subkategoriyalar: $data');
      return data.map((e) => SubCategoryModel.fromJson(e)).toList();
    } else {
      // log('Subkategoriyalarni yuklab bo‘lmadi: ${response.data["result"]}');
      throw Exception('Subkategoriyalarni yuklab bo‘lmadi');
    }
  }

Future<List<BookModel>> fetchBooks({
    int? categoryId,
    int? subCategoryId,
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await dioClient.dio.get(
      '/book/list/',
      // queryParameters: {
      //   if (categoryId != null) 'category': categoryId,
      //   if (subCategoryId != null) 'sub_category': subCategoryId,
      //   'limit': limit,
      //   'offset': offset,
      // },
    );

    if (response.statusCode == 200) {
      final data = response.data['result'] as List;
      return data.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Kitoblarni yuklab bo‘lmadi');
    }
  }
}
