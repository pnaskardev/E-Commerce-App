import 'package:ecommerce/providers/orders.dart' show Orders;
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OrdersScreen extends StatelessWidget 
{
  static const routeName='/orders';

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {

    final orderData=Provider.of<Orders>(context);

    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder
      (
        itemCount: orderData.orderLen,
        itemBuilder: ((context, index) 
        {
           return OrderItem(order: orderData.orders[index]); 
        })
      ),
    );
  }
}