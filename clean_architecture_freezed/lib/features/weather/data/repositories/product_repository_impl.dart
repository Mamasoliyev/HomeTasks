import 'package:clean_architecture_freezed/features/weather/data/datasource/product_remote_data_source.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<String>> getAllCategories() {
    return remoteDataSource.getAllCategories();
  }

  @override
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    final products = await remoteDataSource.getProductsByCategory(category);
    return products
        .map(
          (json) => ProductEntity(
            id: json['id'],
            title: json['title'],
            description: json['description'],
            price: (json['price'] as num).toDouble(),
            category: json['category'],
            image: json['image'],
          ),
        )
        .toList();
  }
}
