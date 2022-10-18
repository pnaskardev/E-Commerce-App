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

    // final orderData=Provider.of<Orders>(context);

    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder
        (
          future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
          builder: (ctx,dataSnapshot)
          {
            if(dataSnapshot.connectionState==ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator());
            }
            else if(!dataSnapshot.hasData)
            {
              return Consumer<Orders>(builder: (ctx, orderData, child) =>
              ListView.builder
              (
                itemCount: orderData.orders.length,
                itemBuilder: (ctx,i)=>OrderItem(order:orderData.orders[i]),

              ) ,);
            }
            return const Center(child: Text('there are no orders'),);
            

            // ListView.builder
            // (
            //   itemCount: orderData.orderLen,
            //   itemBuilder: ((context, index) 
            //   {
            //     return OrderItem(order: orderData.orders[index]); 
            //   })
            // )
            
            // return Consumer<Orders>(builder: (ctx, orderData, child) =>
            // ListView.builder
            // (
            //   itemCount: orderData.orders.length,
            //   itemBuilder: (ctx,i)=>OrderItem(order:orderData.orders[i]),

            // ) ,);
          },
        ),
        
      ),
    );
  }
}