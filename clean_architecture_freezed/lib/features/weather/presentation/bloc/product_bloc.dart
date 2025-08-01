import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../domain/repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await repository.getAllCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<SelectCategory>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await repository.getProductsByCategory(event.category);
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
