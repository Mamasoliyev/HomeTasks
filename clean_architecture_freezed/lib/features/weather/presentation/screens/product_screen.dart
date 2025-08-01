import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import 'product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedCategory = 'all'; // Default category
  List<String> categories = [
    'all',
   
  ]; // Persist categories here

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadCategories());
    context.read<ProductBloc>().add(SelectCategory(selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mahsulotlar')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is CategoryLoading || state is ProductInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          // Update categories when CategoryLoaded state is received
          if (state is CategoryLoaded) {
            categories = ['all', ...state.categories.cast<String>()];
          }

          // Ensure selectedCategory is valid
          final String currentValue = categories.contains(selectedCategory)
              ? selectedCategory
              : 'all';

          return Column(
            children: [
              // Dropdown
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: currentValue,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                      context.read<ProductBloc>().add(SelectCategory(value));
                    }
                  },
                  items: categories
                      .map(
                        (cat) => DropdownMenuItem<String>(
                          value: cat,
                          child: Text(cat[0].toUpperCase() + cat.substring(1)),
                        ),
                      )
                      .toList(),
                ),
              ),

              // Products list
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state is ProductsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductsLoaded) {
                      if (state.products.isEmpty) {
                        return const Center(child: Text('Mahsulot topilmadi'));
                      }

                      return ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ListTile(
                            leading: Image.network(
                              product.image,
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                            title: Text(product.title),
                            subtitle: Text(
                              '\$${product.price.toStringAsFixed(2)}',
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetailScreen(product: product),
                                ),
                              );
                            },
                          );
                        },
                      );
                    } else if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
