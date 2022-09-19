import 'package:flutter/material.dart';

class CartItem with ChangeNotifier
{
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem
  (
    {
      required this.id,
      required this.title,
      required this.quantity,
      required this.price,
    }
  );
  
  get getId => id;
  get getTitle => title;
  get getQuantity => quantity;
  get getPrice => price;
}

class Cart with ChangeNotifier
{
  
  late Map<String,CartItem> _items={};
  Map<String,CartItem> get items
  {
    return {..._items};
  }
  
  int get ItemCount
  {
    return _items.length;
  }
  
  double get totalAmount
  {
    double total=0.0;
    _items.forEach((key, cardItem) 
    {
      total+=cardItem.price*cardItem.quantity;
    });
    return total;
  }

  void addItem(String productId,double price,String title)
  {
    if(_items.containsKey(productId))
    {
      _items.update
      (
        productId, 
        (existingCartItem) => CartItem
          (
            id: existingCartItem.id, 
            title: existingCartItem.title, 
            quantity: existingCartItem.quantity+1,
            price: price
          )
        );
    }
    else
    {
      _items.putIfAbsent
      (
        productId, 
        ()=>CartItem
        (
          id: DateTime.now.toString(), 
          title: title, 
          quantity: 1, 
          price: price
        )
      );
    }
    notifyListeners();
  }

  void removeItem(String productID)
  {
    _items.remove(productID);
    notifyListeners();
  }

  void removeSingleItem(String productId)
  {
    if(!_items.containsKey(productId))
    {
      return;
    }
    if(_items[productId]!.quantity>1)
    {
      _items.update
      (
        productId, (existValue) => CartItem
          (
            id: existValue.id, 
            title: existValue.title, 
            quantity: existValue.quantity-1, 
            price: existValue.price
          )
        );
    }
    else
    {
      _items.remove(productId);
    }
    notifyListeners();
  }


  void clear()
  {
    _items={};
    notifyListeners();
  }

}