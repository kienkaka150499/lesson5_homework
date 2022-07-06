import 'package:flutter/material.dart';

import 'models/product.dart';

class ProductScreen extends StatelessWidget {
  Product product;

  ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              child: Stack(
            children: [
              Image.asset(product.imageURL,height: 450,width: 450,fit: BoxFit.cover,),
              Positioned(
                  top: 50,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )),
              Positioned(top: 370,left: 70,
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black.withOpacity(0.3)),
                    child: Text(
                product.name,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
                  ))
            ],
          )),
          Text(product.price,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 30),
              textAlign: TextAlign.center),
          Text(
            product.description,
            style: TextStyle(fontSize: 17),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
