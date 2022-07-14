import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/product.dart';
import '../utils/dimen_utils.dart';

class CartScreen extends StatefulWidget {
  List<Product> products;

  CartScreen({required this.products});

  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var price = 0.0;

  @override
  initState() {
    for (var i = 0; i < widget.products.length; i++) {
      price += widget.products[i].price * widget.products[i].inCart;
    }
    super.initState();
  }

  Widget _buildListItem() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: getSizeWidth(40)),
        width: getSizeWidth(1000),
        height: getSizeHeight(1500),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: getSizeWidth(1000),
                height: getSizeHeight(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: getSizeWidth(20)),
                      width: getSizeWidth(150),
                      height: getSizeHeight(150),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.purple,
                      ),
                      child: Center(
                        child: Text(
                          '\$${widget.products[index].price.toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.all(getSizeWidth(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.products[index].name,
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Total: \$${(widget.products[index].price * widget.products[index].inCart).toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState((){
                            widget.products[index].inCart--;
                            price-=widget.products[index].price;
                            if(widget.products[index].inCart<=0){
                              widget.products.removeAt(index);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.pink,
                          size: 40,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${widget.products[index].inCart}x',
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState((){
                            widget.products[index].inCart++;
                            price+=widget.products[index].price;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, index) => Divider(),
            itemCount: widget.products.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: getSizeWidth(60),
          ),
        ),
        title: const Text('Your Cart'),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(getSizeWidth(20)),
          child: Column(
            children: [
              Container(
                width: getSizeWidth(1040),
                height: getSizeHeight(200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(getSizeWidth(20)),
                        child: const Text(
                          'Total',
                          style: TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    Container(
                      width: getSizeWidth(200),
                      height: getSizeHeight(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.purple,
                      ),
                      child: Center(
                        child: Text(
                          '\$${price.toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: getSizeWidth(20)),
                      width: getSizeWidth(350),
                      height: getSizeHeight(100),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple,
                      ),
                      child: const Center(
                        child: Text(
                          'ORDER NOW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildListItem(),
            ],
          ),
        ),
      ),
    );
  }
}
