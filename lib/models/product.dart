class Product {
  int id;
  String imageURL;
  String name;
  String price;
  String description;
  bool favorite=false;
  bool inCart=false;

  Product(
      {required this.id,
      required this.imageURL,
      required this.name,
      required this.price,
      required this.description});
}
