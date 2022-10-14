// ignore_for_file: sort_child_properties_last

import 'package:ecommerce/providers/cart.dart';
import 'package:ecommerce/providers/products_provider.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/widgets/app_drawer.dart';
import 'package:ecommerce/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../widgets/ProductsGrid.dart';

enum FilterOptions
{
  favs,
  all,
}


class ProductsOverviewScreen extends StatefulWidget 
{
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> 
{
  
  
  bool _showfavs=false;
  var _isInit=true;
  var _isLoading=false;
  @override
  void initState() 
  {
    // Provider.of<Products>(context).fetchAndSetProducts(); WONT WORK
    //  below code can also be used as hack around
    // Future.delayed(Duration.zero).then((_)
    // {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies()
  {
    if(_isInit==true)
    {
      setState(() 
      {
        _isLoading=true;  
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_)
      {
        setState(() 
        {
          _isLoading=false;  
        });
      });
    }
    _isInit=false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) 
  {

    final productsContainer=Provider.of<Products>(context,listen: false);
    return SafeArea
    (
      child: Scaffold
      (
        appBar: AppBar
        (
          title: const Text('MyShop'),
          actions: <Widget> 
          [
            PopupMenuButton
            (
              onSelected:(FilterOptions selectedValue )
              {
                setState(() 
                {
                  if(selectedValue==FilterOptions.favs)
                  {
                      _showfavs=true;
                  }
                  else
                  {
                    _showfavs=false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_)=>
              [
                const PopupMenuItem
                (
                  child: Text('Only Favs'),
                  value: FilterOptions.favs,
                ),
                const PopupMenuItem
                (
                  child: Text('Show all'),
                  value: FilterOptions.all,
                ),
              ]
            ),
            Consumer<Cart>
            (
              builder: (_, cart, ch) => Badge
              (
                child: ch!,
                value: cart.ItemCount.toString(),
              ),
              child: IconButton
              (
                icon: const Icon
                (
                  Icons.shopping_cart,
                ),
                onPressed: ()
                {
                  Navigator.of(context).pushNamed(cartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body:_isLoading ? const Center
        (
          child: CircularProgressIndicator(),
        ) : ProductsGrid(_showfavs),
      ),
    );
  }
}