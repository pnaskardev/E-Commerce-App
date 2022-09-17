import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: Row
            (
              children: <Widget>
              [
                Row
                (
                  children:  <Widget>
                  [
                    const Text
                    (
                      'total',
                      style: TextStyle(fontSize: 20),
                      
                    ),
                    const SizedBox(width: 10,),
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
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}