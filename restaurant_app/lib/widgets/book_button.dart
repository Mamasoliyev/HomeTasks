
import 'package:flutter/material.dart';
import 'package:food_app/providers/book_provider.dart';
import 'package:provider/provider.dart';

class Buttonbooked extends StatefulWidget {
  Map<String, dynamic> restaurant;
  Buttonbooked({super.key, required this.restaurant});

  @override
  State<Buttonbooked> createState() => _ButtonbookedState();
}

class _ButtonbookedState extends State<Buttonbooked> {
  bool isAdded = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isAdded == false) {
          Provider.of<BookProvider>(
            context,
            listen: false,
          ).addRestaurant(widget.restaurant);
        } else {
          Provider.of<BookProvider>(
            context,
            listen: false,
          ).removeRestaurant(widget.restaurant);
        }
        setState(() {
          isAdded = !isAdded;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.restaurant['name']} booked!")),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isAdded ? Colors.grey : Colors.green,
        foregroundColor: Colors.white,
      ),
      child: Text('Book'),
    );
  }
}
