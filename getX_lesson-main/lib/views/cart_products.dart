import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Obx(
            () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = cartController.cartItems[index];
                  return ListTile(
                    leading: cartItem.product.images.isNotEmpty
                        ? Image.network(
                      cartItem.product.images[0],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : const Icon(Icons.image),
                    title: Text(cartItem.product.title),
                    subtitle: Text('\$${cartItem.product.price}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => cartController.decrementQuantity(cartItem.product.id),
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => cartController.incrementQuantity(cartItem.product.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => cartController.removeFromCart(cartItem.product.id),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total: \$${cartController.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}