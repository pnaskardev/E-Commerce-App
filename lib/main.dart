import 'package:ecommerce/auth/auth.dart';
import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/providers/orders.dart';
import 'package:ecommerce/screens/auth_screen.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/edit_product_screen.dart';
import 'package:ecommerce/screens/orders_screen.dart';
import 'package:ecommerce/screens/user_products_screen.dart';
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
          create: (context)=>Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>
        (
          create: (ctx) => Products(authToken: '',userId: '',items:[]),
          update: (ctx, auth, previousProduct) => Products
            (
              authToken: auth.token,
              userId: auth.userId ,
              items: previousProduct==null ? [] : previousProduct.items
            ),
        ),
        ChangeNotifierProvider
        (
          create: (context)=>Cart()
        ),
        ChangeNotifierProxyProvider<Auth,Orders>
        (
          create: (ctx)=>Orders(authToken: '',userId: '',orders:[]),
          update: (ctx,auth,previousOrders)=>Orders
          (
            authToken: auth.token,
            userId: auth.userId,
            orders: previousOrders==null ? [] : previousOrders.orders
          ),
        ),
      ],
      // ignore: sort_child_properties_last
      child: Consumer<Auth>
      (builder: (ctx,auth,_)=>
        MaterialApp
        (
          title: 'MyShopApp',
          theme: ThemeData
          (
              primarySwatch: Colors.deepPurple,
              textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
              textButtonTheme: TextButtonThemeData
              (
                style:ButtonStyle
                (
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>
                  (
                    (Set<MaterialState> states)
                    {
                      if (states.contains(MaterialState.hovered))
                      {
                        return Colors.blue.withOpacity(0.04);
                      }
                      if (states.contains(MaterialState.focused) ||states.contains(MaterialState.pressed))
                      {
                        return Colors.blue.withOpacity(0.12);
                      }
                      return null;
                    }
                  )
                )
              ),
          ),
          home: SafeArea
          (
            child:auth.isAuth ? ProductsOverviewScreen() : AuthScreen()
            // child:ProductsOverviewScreen()
          ),
          routes: 
          {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            cartScreen.routeName:(context) => const cartScreen(),
            OrdersScreen.routeName:(context) => const OrdersScreen(),
            UserProductsScreen.routeName:(context) => const UserProductsScreen(),
            EditProductScreen.routeName:(context) => const EditProductScreen(),
          },
        )
      )
      // child:MaterialApp
      //   (
      //     title: 'MyShopApp',
      //     theme: ThemeData
      //     (
      //         primarySwatch: Colors.deepPurple,
      //         textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      //         textButtonTheme: TextButtonThemeData
      //         (
      //           style:ButtonStyle
      //           (
      //             foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      //             overlayColor: MaterialStateProperty.resolveWith<Color?>
      //             (
      //               (Set<MaterialState> states)
      //               {
      //                 if (states.contains(MaterialState.hovered))
      //                 {
      //                   return Colors.blue.withOpacity(0.04);
      //                 }
      //                 if (states.contains(MaterialState.focused) ||states.contains(MaterialState.pressed))
      //                 {
      //                   return Colors.blue.withOpacity(0.12);
      //                 }
      //                 return null;
      //               }
      //             )
      //           )
      //         ),
      //     ),
      //     home: SafeArea
      //     (
      //       // child:auth.isAuth ? ProductsOverviewScreen() : AuthScreen()
      //       child:ProductsOverviewScreen()
      //     ),
      //     routes: 
      //     {
      //       ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      //       cartScreen.routeName:(context) => const cartScreen(),
      //       OrdersScreen.routeName:(context) => const OrdersScreen(),
      //       UserProductsScreen.routeName:(context) => const UserProductsScreen(),
      //       EditProductScreen.routeName:(context) => const EditProductScreen(),
      //     },
      //   ),
    );
  }
}
