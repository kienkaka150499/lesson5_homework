
import 'package:flutter/material.dart';
import 'package:lesson5_homework/controllers/cart_item.dart';
import 'package:lesson5_homework/controllers/fake_data.dart';
import 'package:lesson5_homework/models/product.dart';
import 'package:lesson5_homework/views/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CartItem()),
        ChangeNotifierProvider(create: (context)=>FakeProductList()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return ScreenUtilInit(
    //   designSize: const Size(1080, 1920),
    //   builder: (BuildContext context, Widget? child) => const MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     home: HomeScreen(),
    //   ),
    // );

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
