// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
class CartItem extends StatelessWidget 
{

  final String id;
  final double price;
  final int quantity;
  final String title;
  const CartItem
  ({
    super.key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title
  });

  


  @override
  Widget build(BuildContext context) 
  {
    return Card
    (
      margin: const EdgeInsets.symmetric
      (
        horizontal: 15,
        vertical: 4
      ),
      child: Padding
      (
        padding: const EdgeInsets.all(8),
        child: ListTile
        (
          leading: CircleAvatar
          (
            // ignore: unnecessary_brace_in_string_interps
            child: Padding
            (
              padding: const EdgeInsets.all(5.0),
              child: FittedBox(child: Text('\$${price}')),
            ),
          ),
          // ignore: unnecessary_brace_in_string_interps
          title: Text('\ ${title}'),
          subtitle: Text('Total:\$${price*quantity}'),
          // ignore: unnecessary_brace_in_string_interps
          trailing: Text('\ ${quantity}'),
        ),
      ),
    );
  }
}