import 'package:flutter/material.dart';

class Product extends ChangeNotifier{
  String imageURL;
  String name;
  double price;
  String description;
  bool favorite = false;
  int inCart = 0;
  double totalPrice=0;

  Product(
      {required this.imageURL,
      required this.name,
      required this.price,
      required this.description}){
   totalPrice=price*inCart;
  }

  void updateFavorie(){
    favorite=!favorite;
    notifyListeners();
  }

  void addToCart(int number){
    inCart+=number;
    totalPrice=price*inCart;
    notifyListeners();
  }

  // void subItemInCart(){
  //   inCart--;
  //   totalPrice-=price;
  //   notifyListeners();
  // }
}
