import 'package:ecommerce/providers/orders.dart' show Orders;
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OrdersScreen extends StatefulWidget 
{
  static const routeName='/orders';

  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> 
{

  Future? _ordersFuture;

  Future _obstainOrdersFuture()
  {
    return Provider.of<Orders>(context,listen: false).fetchAndSetOrders();
  }

  @override
  void initState() 
  {
    // TODO: implement initState
    _ordersFuture=_obstainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {

    // final orderData=Provider.of<Orders>(context,listen: false);

    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          title: const Text('Your Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder<void>
        (
          // future: Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
          future: _ordersFuture,
          builder: (ctx,dataSnapshot)
          {
            if(dataSnapshot.connectionState==ConnectionState.waiting)
            {
              return const Center(child: CircularProgressIndicator());
            }
            else if(dataSnapshot.hasError)
            {
              return Center(child: Text('aa${dataSnapshot.error}'));
            }
            if(dataSnapshot.hasData)
            {
              return const Center(child: Text('there are no orders'));
            }
            return Consumer<Orders>(builder: (ctx, orderData, child) =>
            ListView.builder
            (
              itemCount: orderData.orders.length,
              itemBuilder: (ctx,i)=>OrderItem(order:orderData.orders[i]),

            ) ,);     

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