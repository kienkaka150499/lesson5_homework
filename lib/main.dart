import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:lesson5_homework/product_screen.dart';
import 'package:text_scroll/text_scroll.dart';

import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [
    Product(
        id: 1,
        imageURL: 'assets/images/ao_so_mi_nam.png',
        name: 'Áo Sơ mi',
        price: '\$12.6',
        description: 'Áo sơ mi nam dài tay'),
    Product(
        id: 2,
        imageURL: 'assets/images/aothun.png',
        name: 'Áo thun',
        price: '\$15.3',
        description: 'Áo thun thể thao nam'),
    Product(
        id: 3,
        imageURL: 'assets/images/mu_tron.png',
        name: 'Mũ vành',
        price: '\$6.6',
        description: 'Mũ tròn cá tính'),
    Product(
        id: 4,
        imageURL: 'assets/images/vay_xep.png',
        name: 'Váy xếp',
        price: '\$15.8',
        description: 'Váy xếp ngắn nữ tính'),
    Product(
        id: 5,
        imageURL: 'assets/images/chan_vay_dai_cong_so.png',
        name: 'Chân váy dài',
        price: '\$21.9',
        description: 'Chân váy dài công sở dành cho chị em'),
  ];
  List<int> inCart = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.8),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        title: const Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
          Badge(
            position: BadgePosition.topEnd(top: 5, end: 8),
            toAnimate: false,
            // animationType: BadgeAnimationType.scale,
            // animationDuration: const Duration(milliseconds: 300),
            badgeContent: Text(
              inCart.length.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            showBadge: inCart.isEmpty ? false : true,
            badgeColor: Colors.red,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
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
                        ),
                      ),
                      Container(
                        height: 45,
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
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  products[index].favorite =
                                      !products[index].favorite;
                                });
                              },
                              icon: products[index].favorite
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.purpleAccent,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.purpleAccent,
                                    ),
                            ),
                            Expanded(
                                child: TextScroll(
                              products[index].name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                              textAlign: TextAlign.center,
                                  mode: TextScrollMode.bouncing,
                                  velocity: Velocity(pixelsPerSecond: Offset(40,0)),
                                  pauseBetween: Duration(seconds: 1),
                            )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    inCart.contains(products[index].id)
                                        ? inCart.remove(products[index].id)
                                        : inCart.add(products[index].id);
                                  });
                                },
                                icon: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.purpleAccent,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                childAspectRatio: 3 / 2),
          ),
        ),
      ),
    );
  }
}
