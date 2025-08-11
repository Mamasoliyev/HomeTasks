import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_darsi/model/product_model..dart';
import 'package:getx_darsi/screens/detail_screen.dart';
import 'package:getx_darsi/viev_model/getx_controller.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Hello, Welcome👋",
                style: TextStyle(
                  fontSize: 13,
                  color: const Color.fromARGB(255, 110, 109, 109),
                ),
              ),

              Text(
                "Nabiyev K",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        actionsPadding: EdgeInsets.only(right: 10),

        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: Icon(Icons.person, color: Colors.grey.shade700),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.products.isEmpty) {
          return Center(child: Text("Productlar topilmadi !"));
        } else if (controller.errorText.isNotEmpty) {
          return Center(
            child: Text("Error beryabdi : ${controller.errorText}"),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
              child: Column(
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 55,
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "Search Product",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 50,
                        width: 50,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.tune, color: Colors.white),
                          style: IconButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Colors.black,
                            focusColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  Expanded(
                    child: GridView.builder(
                      itemCount: controller.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.55,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final ProductModel product = controller.products[index];

                        return ProductCard(product: product);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(DetailScreen(product: product)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.network(
                        product.images?.first ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child: Icon(Icons.broken_image)),
                      ),
                    ),

                    Positioned(
                      right: 5,
                      top: 5,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Text(
              product.title ?? 'Noma\'lum',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            Text(
              product.category!.name ?? 'Noma\'lum',
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price!.toStringAsFixed(2)} ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                  DateFormat('dd.MM.yyyy').format(
                    DateTime.parse(
                      product.category!.creationAt ?? DateTime.now().toString(),
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       final cartController = Get.find<CardController>();
            //       cartController.addProduct(product);
            //       Get.snackbar(
            //         'Savatcha',
            //         '${product.title} savatchaga qo\'shildi',
            //         snackPosition: SnackPosition.TOP,
            //         duration: Duration(seconds: 1),
            //       );
            //     },
            //     child: Text("Qo'shish"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
