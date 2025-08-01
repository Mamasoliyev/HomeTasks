import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUsecase {
  final ProductRepository repository;

  GetProductsByCategoryUsecase(this.repository);

  Future<List<ProductEntity>> call(String category) {
    return repository.getProductsByCategory(category);
  }
}
