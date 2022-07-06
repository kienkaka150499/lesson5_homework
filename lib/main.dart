import 'package:flutter/material.dart';
import 'package:lesson5_homework/product_screen.dart';

import 'models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
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
  List<bool> favorite=[];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.withOpacity(0.8),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        title: Text(
          'MyShop',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.white),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.shopping_cart, color: Colors.white))
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
            child: GridView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                if(index>=favorite.length){
                  favorite.add(false);
                }
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
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            products[index].imageURL,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 60,
                          child: Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState((){
                                        favorite[index]=!favorite[index];
                                      });
                                    },
                                    icon: favorite[index]?Icon(
                                      Icons.favorite,
                                      color: Colors.purpleAccent,
                                    ):Icon(
                                      Icons.favorite_border,
                                      color: Colors.purpleAccent,
                                    ),),
                                Expanded(
                                    child: Text(
                                  products[index].name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.purpleAccent,
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 3 / 2),
            ),
          ),
        ),
      ),
    );
  }
}
