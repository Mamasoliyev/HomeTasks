import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_darsi/model/product_model..dart';
import 'package:getx_darsi/viev_model/card_controller.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  int selectedSizeIndex = 0;
  int selectedColorIndex = 0;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<Color> colors = [Colors.grey, Colors.blueGrey, Colors.black];

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CardController>();
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: product.images?.length ?? 1,
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          product.images?[index] ?? '',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new),
                          onPressed: () => Get.back(),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              maxLines: 1,
                              product.title ?? '',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                style: IconButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000),

                                    side: BorderSide(color: Colors.grey),
                                  ),

                                  minimumSize: Size(10, 10),
                                  foregroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                                icon: Icon(Icons.remove),
                              ),
                              SizedBox(width: 6),
                              Text('$quantity', style: TextStyle(fontSize: 18)),
                              SizedBox(width: 6),

                              IconButton(
                                style: IconButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1000),

                                    side: BorderSide(color: Colors.grey),
                                  ),
                                ),
                                onPressed: () => setState(() => quantity++),
                                icon: Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Text(
                            " 5.0 ",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          Text(
                            "(7,932 sharh)",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),

                      const SizedBox(height: 7),
                      Text(
                        product.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),

                      Divider(),

                      Row(
                        children: [
                          Text(
                            "Choose Size",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          Spacer(),
                          Text(
                            "Color",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          SizedBox(width: 50),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Row(
                            children: List.generate(sizes.length, (index) {
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => selectedSizeIndex = index),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedSizeIndex == index
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                    // borderRadius: BorderRadius.circular(1008),
                                    color: selectedSizeIndex == index
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      sizes[index],
                                      style: TextStyle(
                                        color: selectedSizeIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),

                          Spacer(),

                          Row(
                            children: List.generate(colors.length, (index) {
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => selectedColorIndex = index),
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedColorIndex == index
                                          ? Colors.black
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: colors[index],
                                    radius: 15,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  for (int i = 0; i < quantity; i++) {
                    cartController.addProduct(product);
                  }
                  Get.snackbar(
                    'Savatcha',
                    '${product.title} savatchaga qo‘shildi!',
                    snackPosition: SnackPosition.TOP,
                  );
                },
                child: Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_shopping_cart_outlined, size: 22),
                    Text(
                      "Add to Cart | \$${(product.price ?? 0) * quantity}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
