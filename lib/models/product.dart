class Product {
  String imageURL;
  String name;
  double price;
  String description;
  bool favorite = false;
  int inCart = 0;

  Product(
      {required this.imageURL,
      required this.name,
      required this.price,
      required this.description});
}
