import 'package:flutter/material.dart';
class UserProductItem extends StatelessWidget 
{


  final String title;
  final String imageUrl;
  const UserProductItem
  (
    {
      super.key,
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
              onPressed: (){}, 
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