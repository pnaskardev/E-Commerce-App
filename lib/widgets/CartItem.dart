// ignore_for_file: unused_local_variable
import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartItem extends StatelessWidget 
{

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  const CartItem
  ({
    super.key,
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId
  });

  


  @override
  Widget build(BuildContext context) 
  {
    return Dismissible
    (
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      onDismissed: (direction)
      {
        Provider.of<Cart>(context,listen: false).removeItem(productId);
      },
      background: Container
      (
        color: Theme.of(context).errorColor,
        // ignore: sort_child_properties_last
        child: const Icon
        (
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment:Alignment.centerRight ,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric
        (
          horizontal: 15,
          vertical: 4
        ),
      ),
      child: Card
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
            trailing: Text('\ ${quantity}x'),
          ),
        ),
      ),
    );
  }
}