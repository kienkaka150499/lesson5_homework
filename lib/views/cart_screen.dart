import 'package:flutter/material.dart';
import 'package:lesson5_homework/controllers/cart_item.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class CartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var price = 0.0;
  late double _width;
  late double _height;
  bool isDeleteTap = false;
  List<bool> deleteChecked = [];
  List<Product> productBeforeDelete = [];

  @override
  initState() {
    super.initState();
  }

  Widget _buildListItem() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        width: _width,
        height: _height - 200,
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                width: _width - 70,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    if (isDeleteTap)
                      SizedBox(
                        width: 20,
                        child: Checkbox(
                          onChanged: (bool? value) {
                            setState(() {
                              deleteChecked[index] = value!;
                            });
                          },
                          value: deleteChecked[index],
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.purple,
                      ),
                      child: Center(
                        child: Text(
                          '\$${context.read<CartItem>().productList[index].price.toStringAsFixed(1)}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.read<CartItem>().productList[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Total: \$${(context.read<CartItem>().productList[index].totalPrice).toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 15,
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
                          setState(() {
                            context
                                .read<CartItem>()
                                .productList[index]
                                .addToCart(-1);
                            if (context
                                    .read<CartItem>()
                                    .productList[index]
                                    .inCart <=
                                0) {
                              context
                                  .read<CartItem>()
                                  .productList
                                  .removeAt(index);
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.pink,
                          size: 25,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${context.read<CartItem>().productList[index].inCart}x',
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            context
                                .read<CartItem>()
                                .productList[index]
                                .addToCart(1);
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, index) => const Divider(),
            itemCount: context.read<CartItem>().productList.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        title: const Text('Your Cart'),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                width: _width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: const Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.purple,
                      ),
                      child: Center(
                        child: Consumer<CartItem>(
                          builder: (context, cartItem, child) {
                            return Text(
                              '\$${cartItem.totalPrice.toStringAsFixed(1)}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple,
                      ),
                      child: const Center(
                        child: Text(
                          'ORDER NOW',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        int count = 0;
                        isDeleteTap = !isDeleteTap;
                        if (isDeleteTap) {
                          for (var index = 0;
                              index <
                                  context.read<CartItem>().productList.length;
                              index++) {
                            deleteChecked.add(false);
                          }
                        } else {
                          productBeforeDelete.clear();
                          productBeforeDelete.addAll(
                              (context.read<CartItem>().productList),);
                          for (var index =
                                  context.read<CartItem>().productList.length -
                                      1;
                              index >= 0;
                              index--) {
                            if (deleteChecked[index]) {
                              context
                                  .read<CartItem>()
                                  .productList
                                  .removeAt(index);
                              count++;
                            }
                          }
                          deleteChecked.clear();
                        }
                        if (count > 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text('Đã xóa $count Item!'),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<CartItem>().productList.clear();
                                        context.read<CartItem>().productList.addAll(
                                            productBeforeDelete);
                                        setState(() {});
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                      ),
                                      child: const Text(
                                        'Undo',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        width: 120,
                        height: 50,
                        child: Center(
                          child: Text(
                            isDeleteTap ? 'Delete selected' : 'Delete',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: isDeleteTap ? 17 : 20,
                            ),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
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
