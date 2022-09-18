import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/cupertino.dart';

class OrderItem
{
  final String id;
  final double amount;
  final List<CartItem>products;
  final DateTime dateTime;

  OrderItem
  (
    {
      required this.id,
      required this.amount,
      required this.products,
      required this.dateTime,
    }
  );

}

class Orders with ChangeNotifier
{
  // ignore: prefer_final_fields
  List<OrderItem>_orders=[];
  List<OrderItem> get orders
  {
    return _orders;
  }

  int get orderLen
  {
    return orders.length;
  }

  void addOrder(List<CartItem>cartProducts,double total)
  {
    _orders.insert(0, OrderItem
    (
      id: DateTime.now().toString(), 
      amount: total, 
      products: cartProducts, 
      dateTime: DateTime.now()
      
    ));
    notifyListeners();
  }


}