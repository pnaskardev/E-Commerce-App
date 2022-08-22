import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget 
{

  final String id;
  final String title;
  final String imageUrl;

  ProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) 
  {
    return ClipRRect
    (
      borderRadius: BorderRadius.circular(15),
      child: GridTile
      (
        child: Image.network
        (
          imageUrl,
          fit: BoxFit.cover,
        ),
        footer: GridTileBar
        (
          leading: IconButton
          (
            onPressed: (){}, 
            icon: const Icon(Icons.favorite)
          ),
          backgroundColor: Colors.black54,
          title: Text
          (
            title,textAlign: TextAlign.center,
          ),
          trailing: IconButton
          (
            onPressed: (){}, 
            icon: const Icon(Icons.shopping_basket_outlined)  
          ),
        ),
      ),
    );  
  }
}