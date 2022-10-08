import 'package:ecommerce/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
class UserProductItem extends StatelessWidget 
{

  final String id;
  final String title;
  final String imageUrl;
  const UserProductItem
  (
    {
      super.key,
      required this.id,
      required this.imageUrl,
      required this.title
    }
  );

  @override
  Widget build(BuildContext context) 
  {
    return ListTile
    (
      title: Text(title),
      leading: CircleAvatar
      (
        backgroundImage: NetworkImage(imageUrl),
      ),
      // ignore: sized_box_for_whitespace
      trailing: Container
      (
        width: 100,
        child: Row
        (
          children: 
          [
            IconButton
            (
              onPressed: ()
              {
                Navigator.of(context).pushNamed
                (
                  EditProductScreen.routeName,
                  arguments: id
                );
              }, 
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton
            (
              onPressed: (){}, 
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}