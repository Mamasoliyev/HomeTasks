import 'package:clean_architecture_freezed/features/weather/data/datasource/product_remote_data_source.dart';
import 'package:clean_architecture_freezed/features/weather/data/repositories/product_repository_impl.dart';
import 'package:clean_architecture_freezed/features/weather/domain/repositories/product_repository.dart';
import 'package:clean_architecture_freezed/features/weather/presentation/bloc/product_bloc.dart';
import 'package:clean_architecture_freezed/features/weather/presentation/screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final ProductRepository repository = ProductRepositoryImpl(
    ProductRemoteDataSource(),
  );

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FakeStore Products',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => ProductBloc(repository),
        child: const ProductScreen(),
      ),
    );
  }
}
