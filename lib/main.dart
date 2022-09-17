import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/product_detail.dart';
import 'package:ecommerce/screens/products_overview_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import './providers/products_provider.dart';

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
    return MultiProvider
    (
      providers: 
      [
        ChangeNotifierProvider
        (
          create: (context) => Products(),
        ),
        ChangeNotifierProvider
        (
          create: (context)=>Cart()
        )
      ],
      child: MaterialApp
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
          cartScreen.routeName:(context) => const cartScreen(),
        },
      )
    );
  }
}
