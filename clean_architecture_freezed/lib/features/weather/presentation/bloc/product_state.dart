import '../../domain/entities/product_entity.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class CategoryLoading extends ProductState {}

class CategoryLoaded extends ProductState {
  final List<String> categories;
  CategoryLoaded(this.categories);
}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<ProductEntity> products;
  ProductsLoaded(this.products);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}
