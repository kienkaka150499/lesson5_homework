import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lesson5_homework/views/cart_screen.dart';

import '../models/product.dart';
import 'edit_product.dart';
import 'fake_data.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isListView;
  late bool isShowMenu;


  List<Product> inCart = [];

  @override
  initState() {
    isListView = false;
    isShowMenu = false;
    super.initState();
  }

  Widget _buildSideMenu() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: ScreenUtil().setWidth(isShowMenu ? 300 : 0),
      color: Colors.purple.withOpacity(0.7),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(200),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isListView = true;
              });
            },
            child: SizedBox(
              width: ScreenUtil().setWidth(300),
              height: ScreenUtil().setHeight(70),
              child: const Text(
                'List Products',
                style: TextStyle(fontSize: 27, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Divider(
            thickness: 0,
            color: Colors.purple.withOpacity(0.7),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isListView = false;
              });
            },
            child: SizedBox(
              width: ScreenUtil().setWidth(300),
              height: ScreenUtil().setHeight(70),
              child: const Text(
                'Grid Products',
                style: TextStyle(fontSize: 27, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.8),
        leading: IconButton(
          onPressed: () {
            setState(() {
              isShowMenu = !isShowMenu;
            });
          },
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: ScreenUtil().setHeight(60),
          ),
        ),
        title: const Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: ScreenUtil().setHeight(60),
            ),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 5, end: 9),
            toAnimate: false,
            // animationType: BadgeAnimationType.scale,
            // animationDuration: const Duration(milliseconds: 300),
            badgeContent: Text(
              inCart.length.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            showBadge: inCart.isEmpty ? false : true,
            badgeColor: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () async{
                   await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => CartScreen(products: inCart),
                    ),
                  );
                  setState(() {});
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: ScreenUtil().setHeight(60),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20),
              right: ScreenUtil().setWidth(20),
              left: ScreenUtil().setWidth(isShowMenu ? 320 : 20),
            ),
            child: GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ProductScreen(
                                  product: products[index],
                                )));
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            products[index].imageURL,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width / 2 - 12,
                            errorBuilder: (a, b, c) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: const Icon(Icons.image, size: 150),
                              );
                            },
                          ),
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 2 - 12,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      products[index].favorite =
                                          !products[index].favorite;
                                    });
                                  },
                                  icon: Icon(
                                    products[index].favorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.purpleAccent,
                                    size: 40,
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Text(
                                    products[index].name,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Expanded(
                                child: Badge(
                                  position: BadgePosition.topEnd(
                                      top: 1, end: ScreenUtil().setWidth(10)),
                                  toAnimate: false,
                                  // animationType: BadgeAnimationType.scale,
                                  // animationDuration: const Duration(milliseconds: 300),
                                  badgeContent: Text(
                                    products[index].inCart.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  showBadge: products[index].inCart == 0
                                      ? false
                                      : true,
                                  badgeColor: Colors.red,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (inCart
                                              .contains(products[index])) {
                                            products[index].inCart++;
                                          } else {
                                            (inCart.add(products[index]));
                                            products[index].inCart++;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.shopping_cart,
                                        color: Colors.purpleAccent,
                                        size: 40,
                                      )),
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
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 3 / 2),
            ),
          ),
          _buildSideMenu(),
        ]),
      ),
    );
  }

  Widget _buildListView() {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple.withOpacity(0.8),
          leading: IconButton(
            onPressed: () {
              setState(() {
                isShowMenu = !isShowMenu;
              });
            },
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: ScreenUtil().setHeight(60),
            ),
          ),
          title: const Text(
            'MyShop',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
              child: IconButton(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => EditScreen(),
                    ),
                  );
                  setState(() {
                    if (result != null) {
                      products.add(result);
                    }
                  });
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: ScreenUtil().setWidth(60),
                ),
              ),
            ),
          ]),
      body: SafeArea(
        child: Stack(children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.only(
              top: ScreenUtil().setHeight(20),
              bottom: ScreenUtil().setHeight(20),
              right: ScreenUtil().setWidth(20),
              left: ScreenUtil().setWidth(isShowMenu ? 320 : 20),
            ),
            child: ListView.separated(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var screenSize = MediaQuery.of(context).size;
                return InkWell(
                  onTap: () async {
                    var result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditScreen(product: products[index]);
                      }),
                    );
                    setState(() {
                      products[index] = result;
                    });
                  },
                  child: Container(
                    width: screenSize.width,
                    height: ScreenUtil().setHeight(200),
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(25)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setHeight(75)),
                          child: Image.asset(
                            products[index].imageURL,
                            width: ScreenUtil().setWidth(150),
                            height: ScreenUtil().setHeight(150),
                            fit: BoxFit.cover,
                            errorBuilder: (context, object, trace) {
                              return SizedBox(
                                height: ScreenUtil().setHeight(150),
                                width: ScreenUtil().setWidth(150),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setHeight(75)),
                                  child: const Icon(
                                    Icons.image,
                                    size: 100,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(50),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            products[index].name,
                            style:
                                TextStyle(fontSize: ScreenUtil().setHeight(40)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () async {
                              var result = await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return EditScreen(product: products[index]);
                                }),
                              );
                              setState(() {
                                products[index] = result;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.purple,
                              size: ScreenUtil().setHeight(60),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.business,
                              color: Colors.green,
                              size: ScreenUtil().setHeight(60),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              _deleteItem(index);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: ScreenUtil().setHeight(60),
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
          _buildSideMenu(),
        ]),
      ),
    );
  }

  Future _deleteItem(int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Delete Item',
          style: TextStyle(fontSize: ScreenUtil().setHeight(50)),
        ),
        content: SizedBox(
          width: ScreenUtil().setWidth(800),
          height: ScreenUtil().setHeight(200),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.delete,
                color: Colors.red,
                size: ScreenUtil().setHeight(50),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(50),
              ),
              Text(
                'Are You Sure?',
                style: TextStyle(fontSize: ScreenUtil().setHeight(50)),
              ),
            ]),
          ),
        ),
        actions: [
          SizedBox(
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        products.removeAt(index);
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(75),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
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
    // TODO: implement build
    return isListView ? _buildListView() : _buildGridView();
  }
}
