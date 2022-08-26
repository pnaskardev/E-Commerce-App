import 'package:flutter/material.dart';
import '../widgets/ProductsGrid.dart';
class ProductsOverviewScreen extends StatelessWidget 
{
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}