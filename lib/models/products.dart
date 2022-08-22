class Products
{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imagUrl;
  bool isFav;
  
  Products
  ({
    required this.id,
    required this.title,
    required this.description,
    required this.price, 
    required this.imagUrl,
    this.isFav=false
  });
}