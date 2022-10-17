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
    return SafeArea
    (
      child: Scaffold
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
                    OrderButton(cart: cart)
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
      ),
    );
  }
}

class OrderButton extends StatefulWidget 
{
  const OrderButton
  ({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> 
{
  var _isLoading=false;
  @override
  Widget build(BuildContext context) 
  {
    return TextButton
    (
      // ignore: sort_child_properties_last
      child: _isLoading ? const CircularProgressIndicator() : const Text
      (
        'Order Now',
      ),
      onPressed:(widget.cart.totalAmount<=0.0 || _isLoading) 
      ? null
      : () async
      {
        // print(widget.cart.totalAmount);
        setState(() 
        {
          _isLoading=true;  
        });
        await Provider.of<Orders>(context,listen: false).addOrder
        (
          widget.cart.items.values.toList(), 
          widget.cart.totalAmount
        );

        setState(() 
        {
          _isLoading=false;  
        });
        widget.cart.clear();
      
        
      },
      // onPressed: null,
      
       
      
    );
  }
}