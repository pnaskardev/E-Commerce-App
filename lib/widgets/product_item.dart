import 'package:ecommerce/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail.dart';
import 'package:ecommerce/providers/products.dart';
class ProductItem extends StatelessWidget 
{

  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id,this.title,this.imageUrl);




  @override
  Widget build(BuildContext context) 
  {
    final product=Provider.of<Product>(context);
    final cart=Provider.of<Cart>(context,listen: false);
    return ClipRRect
      (
        borderRadius: BorderRadius.circular(15),
        child: GridTile
        (
          child: GestureDetector
          (
            onTap: ()
            {
              Navigator.of(context).pushNamed
              (
                ProductDetailScreen.routeName,
                arguments: product.id
              );
            },
             child: Image.network
            (
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar
          (
            leading: Consumer<Product>
            (
              builder: (context, product, child) => IconButton
              (
                onPressed: ()
                {
                  product.toogleFavStatus();
                }, 
                icon:Icon(product.isFav ? Icons.favorite:Icons.favorite_border)
              ),
              
            ),
            backgroundColor: Colors.black54,
            title: Text
            (
              product.title,textAlign: TextAlign.center,
            ),
            trailing: IconButton
            (
              onPressed: ()
              {
                cart.addItem(product.id, product.price, product.title);
              }, 
              icon: const Icon(Icons.shopping_basket_outlined)  
            ),
          ),
        ),
      );
  }
}