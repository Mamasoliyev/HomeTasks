import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<String>> getAllCategories();
  Future<List<ProductEntity>> getProductsByCategory(String category);
}
