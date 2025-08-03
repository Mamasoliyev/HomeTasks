import 'package:burger/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatefulWidget {
  ProductModel product;

  DetailScreen({super.key, required this.product});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // final ProductModel products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 20,

                children: [
                  IconButton(
                    onPressed: () => context.go('/'),
                    icon: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFECF0F4),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  Text(
                    'Details',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              Container(
                width: double.infinity,

                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Color(0xFFFFBF6D),
                ),
                child: Hero(
                  tag: widget.product.name!,
                  child: Image.asset("assets/burger.jpg"),
                ),
              ),

              Text(widget.product.name!),
              Text(widget.product.description!),
              Text((widget.product.ingredients!).join(', ')),
            ],
          ),
        ),
      ),
    );
  }
}
