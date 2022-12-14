import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/screens/user_products_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget 
{
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Drawer
    (
      child: Column
      (
        children: 
        [
          AppBar
          (
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile
          (
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: ()
            {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile
          (
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            onTap: (() 
            {
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            }),
          ),
          const Divider(),
          ListTile
          (
            leading: const Icon(Icons.edit),
            title: const Text('Manage Orders'),
            onTap: (() 
            {
              Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
            }),
          ),
        ],
      ),
    );
  }
}