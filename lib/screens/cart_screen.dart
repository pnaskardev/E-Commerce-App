import 'package:ecommerce/providers/cart.dart' show Cart;
import 'package:ecommerce/providers/orders.dart';
import 'package:ecommerce/widgets/CartItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class cartScreen extends StatelessWidget 
{

  static const routeName='/cart';

  const cartScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    final cart=Provider.of<Cart>(context);
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Your Cart'),
      ),
      body: Column
      (
        children: <Widget>
        [
          Card
          (
            margin: const EdgeInsets.all(15),
            child: Padding
            (
              padding: const EdgeInsets.all(8.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                  const Text
                  (
                    'total',
                    style: TextStyle(fontSize: 20),
                    
                  ),
                  const Spacer(),
                  Chip
                  (
                    // label: Text(cart.totalAmount.toString()),
                    label: Text
                    (
                      // ignore: unnecessary_string_interpolations
                      '${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton
                  (
                    onPressed: ()
                    {
                      Provider.of<Orders>(context,listen: false).addOrder
                      (cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    }, 
                    child: const Text
                    (
                      'Order Now',
                    )
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded
          (
            child: ListView.builder
            (
              itemCount: cart.ItemCount,
              itemBuilder: (context, index) 
              {
                return CartItem
                (
                  id:cart.items.values.toList()[index].getId,
                  productId: cart.items.keys.toList()[index],
                  price:cart.items.values.toList()[index].getPrice,
                  quantity: cart.items.values.toList()[index].quantity,
                  title: cart.items.values.toList()[index].title,
                );  
              },
              
            )
          )
        ],
      ),
    );
  }
}