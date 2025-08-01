abstract class ProductEvent {}

class LoadCategories extends ProductEvent {}

class SelectCategory extends ProductEvent {
  final String category;
  SelectCategory(this.category);
}
