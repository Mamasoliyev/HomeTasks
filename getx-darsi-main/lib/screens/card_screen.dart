import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:getx_darsi/viev_model/card_controller.dart';

class CartScreen extends StatelessWidget {
  final CardController controller = Get.find();

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text('Checkout', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.items.isEmpty) {
                return Center(child: Text('Savatcha bo\'sh'));
              }

              return ListView.separated(
                separatorBuilder: (context, index) => Divider(),

                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final product = controller.items.keys.elementAt(index);
                  final quantity = controller.items[product]!;

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      child: Row(
                        spacing: 10,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.network(
                              product.images?.first ?? '',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.broken_image),
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 140,
                                child: Text(
                                  product.title ?? 'Noma\'lum',
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              Text(
                                product.category!.name ?? "no name",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '\$${product.price!.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                            children: [
                              InkWell(
                                onTap: () =>
                                    controller.removeProductCompletely(product),
                                child: Icon(
                                  Icons
                                      .do_not_disturb_on_total_silence_outlined,
                                  size: 25,
                                  color: const Color.fromARGB(255, 220, 3, 3),
                                ),
                              ),

                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      minimumSize: Size(20, 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        side: BorderSide(color: Colors.black),
                                      ),
                                      foregroundColor: Colors.black,
                                    ),
                                    padding: EdgeInsets.all(2),
                                    icon: Icon(Icons.remove),
                                    onPressed: () =>
                                        controller.removeProduct(product),
                                  ),
                                  Text('$quantity'),
                                  IconButton(
                                    padding: EdgeInsets.all(2),
                                    style: IconButton.styleFrom(
                                      minimumSize: Size(10, 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        side: BorderSide(color: Colors.black),
                                      ),
                                      foregroundColor: Colors.black,
                                    ),
                                    icon: Icon(Icons.add),
                                    onPressed: () =>
                                        controller.addProduct(product),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          Obx(
            () => SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 90, left: 10, right: 10),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'total(${controller.items.length} items)',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${controller.totalPrice.toStringAsFixed(2)} \$',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('discount', style: TextStyle(fontSize: 18)),
                          Text(
                            '${0.toStringAsFixed(2)} \$',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sub Total', style: TextStyle(fontSize: 18)),
                          Text(
                            '${controller.totalPrice.toStringAsFixed(2)} \$',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 60),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Pay",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
