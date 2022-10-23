import 'dart:convert';

import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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
      // required this.dateTime,
    }
  );

  

}

class Orders with ChangeNotifier
{
  // ignore: prefer_final_fields
  List<OrderItem>_orders=[];
  final String authToken;
  final String userId;
  Orders
  ({
    required this.authToken,
    required this.userId,
    required List<OrderItem> orders
  }):_orders=orders;


  List<OrderItem> get orders
  {
    return _orders;
  }

  int get orderLen
  {
    return orders.length;
  }

  Future<void> addOrder(List<CartItem>cartProducts,double total) async
  {
    final timeStamp=DateTime.now();
    final url='https://e-commerce-41888-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';    
    final response= await http.post
    (
      Uri.parse(url),
      body: json.encode
      (
        {
          'amount':total,
          'dateTime':timeStamp.toIso8601String(),
          'products':cartProducts.map
          (
            (cp) => 
              {
                'id':cp.id,
                'title':cp.title,
                'quantity':cp.quantity,
                'price':cp.price
              }
            ).toList()

        }
      )
    );

    _orders.insert
    (
      0, 
      OrderItem
      (
        id: json.decode(response.body)['name'], 
        amount: total, 
        products: cartProducts, 
        dateTime: timeStamp
        
      )
    );
    notifyListeners();

  }


  Future<void> fetchAndSetOrders() async
  {
    final url='https://e-commerce-41888-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response= await http.get(Uri.parse(url));
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders=[];
    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    print(response.statusCode);
    if(response.statusCode==200)
    {
      extractedData.forEach((orderId, orderData) 
      {
        loadedOrders.add
        (
          OrderItem
          (
            id: orderId, 
            amount: orderData['amount'], 
            products: (orderData['products'] as List <dynamic>)
            .map
            (
              (item) => 
                CartItem
                (
                  id: item['id'], 
                  title: item['title'], 
                  quantity: item['quantity'], 
                  price: item['price']
                )
            ).toList(), 
              dateTime: DateTime.parse
              (
                orderData['dateTime']
              )
          )
        );
      });
      _orders=loadedOrders.reversed.toList();
      notifyListeners();
    }
    else
    {
      throw Exception('Failed to load orders');
    }
  }
}