import 'package:ecommerce/providers/cart.dart' show Cart;
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
                      '${cart.totalAmount}',
                      style: TextStyle(color: Theme.of(context).primaryColorLight),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton
                  (
                    onPressed: (){}, 
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