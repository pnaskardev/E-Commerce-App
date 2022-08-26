import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import 'package:ecommerce/providers/products_provider.dart';
import '../providers/products_provider.dart';


class ProductsGrid extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {

    final productsData= Provider.of<Products>(context);
    final products=productsData.items;

    return GridView.builder
    (
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider
      (
        create: (context) => products[index],
        child: ProductItem
        (

        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
      (
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10
      ),
    );
  }
}