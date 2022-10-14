import 'package:ecommerce/providers/products_provider.dart';
import 'package:ecommerce/screens/edit_product_screen.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class UserProductsScreen extends StatelessWidget 
{

  static const routeName='/user-products';

  const UserProductsScreen({super.key});

  Future<void>_refreshProducts(BuildContext context) async
  {
    await Provider.of<Products>(context,listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) 
  {
    final productsData=Provider.of<Products>(context,listen: false);
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('Your Products'),
        actions: 
        [
          IconButton
          (
            onPressed: ()
            {
              Navigator.of(context).pushNamed
              (
                EditProductScreen.routeName,
                arguments: ''
              );
            }, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Consumer<Products>
      (
        builder: (_, value, child)=>RefreshIndicator
        (
          onRefresh: () => _refreshProducts(context),
          child: Padding
          (
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder
            (
              itemCount: productsData.items.length,
              itemBuilder: (_,index)
              {
                return Column
                (
                  children: 
                  [
                    UserProductItem
                    (
                      id: productsData.items[index].id,
                      imageUrl: productsData.items[index].imageUrl,
                      title:productsData.items[index].title
                    ),
                    const Divider()
                  ],
                );
              }
            ),
          ),
        ),

      ),

    );
  }
}