import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lesson5_homework/views/cart_screen.dart';
import 'package:provider/provider.dart';

import '../controllers/cart_item.dart';
import '../models/product.dart';
import 'edit_product.dart';
import '../controllers/fake_data.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isListView;

  //late bool isShowMenu;
  late double _width;
  late double _height;

  // FakeProductList productList = FakeProductList();

  // CartItem cartItem=CartItem();

  @override
  initState() {
    isListView = false;
    //isShowMenu = false;
    super.initState();
  }

  Widget _buildGridView() {
    FakeProductList productList = context.watch<FakeProductList>();
    return Scaffold(
      drawer: _buildDrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.8),
        // leading: IconButton(
        //   onPressed: () {
        //     setState(() {
        //       isShowMenu = !isShowMenu;
        //     });
        //   },
        //   icon: const Icon(
        //     Icons.menu,
        //     color: Colors.white,
        //     size: 30,
        //   ),
        // ),
        title: const Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 30,
            ),
          ),
          Consumer<CartItem>(
            builder: (context, cartItem, child) {
              return Badge(
                position: BadgePosition.topEnd(top: 5, end: 12),
                toAnimate: false,
                // animationType: BadgeAnimationType.scale,
                // animationDuration: const Duration(milliseconds: 300),
                badgeContent: Text(
                  cartItem.productList.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                showBadge: cartItem.productList.isEmpty ? false : true,
                badgeColor: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () async {
                      var result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => CartScreen(),
                        ),
                      );
                      for (var product in productList.products) {
                        cartItem.productList.contains(product)
                            ? ''
                            : product.inCart = 0;
                      }
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: GridView.builder(
              itemCount: productList.products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductScreen(
                          product: productList.products[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // margin: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            productList.products[index].imageURL,
                            fit: BoxFit.cover,
                            width: _width < 600 ? _width / 2 : _width / 3,
                            errorBuilder: (a, b, c) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: const Icon(Icons.image, size: 150),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 45,
                          width: _width < 600 ? _width / 2 : _width / 3,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  productList.updateFavoriteState(
                                      productList.products[index]);
                                },
                                icon: Icon(
                                  productList.products[index].favorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.purpleAccent,
                                  size: 30,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  productList.products[index].name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Badge(
                                position: BadgePosition.topEnd(
                                  top: 1,
                                  end: 5,
                                ),
                                toAnimate: false,
                                // animationType: BadgeAnimationType.scale,
                                // animationDuration: const Duration(milliseconds: 300),
                                badgeContent: Text(
                                  productList.products[index].inCart.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                showBadge:
                                    productList.products[index].inCart == 0
                                        ? false
                                        : true,
                                badgeColor: Colors.red,
                                child: IconButton(
                                  onPressed: () {
                                    productList.updateInCart(
                                        productList.products[index]);
                                    context.read<CartItem>().addItemToCart(
                                        productList.products[index]);
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.purpleAccent,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _width < 600 ? 2 : 3,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildListView() {
    FakeProductList productList = context.read<FakeProductList>();
    return Scaffold(
      drawer: _buildDrawerMenu(),
      appBar: AppBar(
          backgroundColor: Colors.purple.withOpacity(0.8),
          // leading: IconButton(
          //   onPressed: () {
          //     setState(() {
          //       isShowMenu = !isShowMenu;
          //     });
          //   },
          //   icon: const Icon(
          //     Icons.menu,
          //     color: Colors.white,
          //     size: 30,
          //   ),
          // ),
          title: const Text(
            'MyShop',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => EditScreen(),
                  ),
                );
                if (result != null) {
                  productList.addItemToList(result);
                }
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ]),
      body: SafeArea(
        child: Stack(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(5),
            child: ListView.separated(
              itemCount: productList.products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    var result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditScreen(product: productList.products[index]);
                      }),
                    );
                    context
                        .read<CartItem>()
                        .updateEditItem(productList.products[index], result);
                    productList.updateItem(result, index);
                  },
                  child: Container(
                    width: _width,
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            productList.products[index].imageURL,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, object, trace) {
                              return SizedBox(
                                height: 80,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: const Icon(
                                    Icons.image,
                                    size: 80,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            productList.products[index].name,
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              var result = await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return EditScreen(
                                      product: productList.products[index]);
                                }),
                              );
                              context.read<CartItem>().updateEditItem(
                                  productList.products[index], result);
                              productList.updateItem(result, index);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.purple,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.business,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              _deleteItem(productList.products[index]);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 2,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Future _deleteItem(Product product) {
    FakeProductList productList = context.read<FakeProductList>();
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Delete Item',
          style: TextStyle(fontSize: 25),
        ),
        content: SizedBox(
          width: 300,
          height: 100,
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 25,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    'Are You Sure?',
                    style: TextStyle(fontSize: 25),
                  ),
                ]),
          ),
        ),
        actions: [
          SizedBox(
            width: 300,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      productList.deleteItem(product);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 120,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    // return Consumer<FakeProductList>(builder: (context, productList, child) {
    //   return isListView
    //       ? _buildListView(productList)
    //       : _buildGridView(productList);
    // });
    return isListView ? _buildListView() : _buildGridView();
  }

  _buildDrawerMenu() {
    return Drawer(
      width: 200,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('ListView'),
            onTap: () {
              setState(() {
                isListView = true;
              });
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('GridView'),
            onTap: () {
              setState(() {
                isListView = false;
              });
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
