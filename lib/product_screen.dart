import 'package:flutter/material.dart';

import 'models/product.dart';

class ProductScreen extends StatelessWidget {
  Product product;

  ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  product.imageURL,
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Text(
                      product.name,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(product.price,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4), fontSize: 30),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Text(
              product.description,
              style: const TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
