import 'package:flutter/material.dart';

import '../models/product.dart';

class FakeProductList extends ChangeNotifier {
  List<Product> products = [
    Product(
        imageURL: 'assets/images/ao_so_mi_nam.png',
        name: 'Áo Sơ mi',
        price: 12.6,
        description: 'Áo sơ mi nam dài tay'),
    Product(
        imageURL: 'assets/images/aothun.png',
        name: 'Áo thun',
        price: 15.3,
        description: 'Áo thun thể thao nam'),
    Product(
        imageURL: 'assets/images/mu_tron.png',
        name: 'Mũ vành',
        price: 6.6,
        description: 'Mũ tròn cá tính'),
    Product(
        imageURL: 'assets/images/vay_xep.png',
        name: 'Váy xếp',
        price: 15.8,
        description: 'Váy xếp ngắn nữ tính'),
    Product(
        imageURL: 'assets/images/chan_vay_dai_cong_so.png',
        name: 'Chân váy dài',
        price: 21.9,
        description: 'Chân váy dài công sở dành cho chị em'),
  ];

  void updateInCart(Product product) {
    product.addToCart(1);
    notifyListeners();
  }

  void updateFavoriteState(Product product) {
    product.updateFavorie();
    notifyListeners();
  }

  void deleteItem(Product product) {
    products.remove(product);
    notifyListeners();
  }

  void addItemToList(Product product){
    products.add(product);
    notifyListeners();
  }

  void updateItem(Product product,int index){
    product.inCart=products[index].inCart;
    product.favorite=products[index].favorite;
    product.addToCart(0);
    products[index]=product;
    notifyListeners();
  }
}
