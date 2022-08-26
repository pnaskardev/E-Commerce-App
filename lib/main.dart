import 'package:flutter/material.dart';
import 'package:ecommerce/screens/product_detail.dart';
import 'package:ecommerce/screens/products_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() 
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: 'MyShopApp',
      theme: ThemeData
      (
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)
      ),
      home: ProductsOverviewScreen(),
      routes: 
      {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
    );
  }
}
