import 'package:flutter/material.dart';

import '../models/product.dart';

class CartItem extends ChangeNotifier {
  List<Product> productList = [];

  double get totalPrice {
    return productList.fold(
        0,
        (double currentTotalPrice, Product nextProduct) =>
            currentTotalPrice + nextProduct.totalPrice);
  }
  
  void addItemToCart(Product product){
    if(!productList.contains(product)){
      productList.add(product);
    }
    notifyListeners();
  }

  void updateEditItem(Product oldProduct,Product newProduct){
    int index=productList.indexOf(oldProduct);
    newProduct.inCart=productList[index].inCart;
    newProduct.favorite=productList[index].favorite;
    newProduct.addToCart(0);
    productList[index]=newProduct;
    notifyListeners();
  }
}
