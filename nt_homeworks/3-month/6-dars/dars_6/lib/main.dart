import 'package:dars_6/model/product2_model.dart';
import 'package:dars_6/model/product_model.dart';
import 'package:dars_6/screen/home_screen.dart';
import 'package:dars_6/service/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HayotSikl(),
      // Scaffold(
      //   body: FutureBuilder(
      //     future: ProductService.fetchProducts(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CupertinoActivityIndicator());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text(snapshot.error.toString()));
      //     }
      //     final List<ProductModel>? products = snapshot.data;
      //     if (products == null || products.isEmpty) {
      //       return Center(child: Text("No todos found"));
      //     }
      //     return ListView.builder(
      //       itemCount: products.length,
      //       itemBuilder: (context, index) {
      //         final ProductModel product = products[index];
      //         return Card(
      //           child: ListTile(
      //             title: Text(product.category ?? "No Title"),
      //             leading: Text(product.brand?? 'No brand'),
      //             trailing: Checkbox(
      //               value: true,
      //               onChanged: (value) {},
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}
