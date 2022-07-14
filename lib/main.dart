import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lesson5_homework/views/home_screen.dart';


void main() {
  runApp(const MyApp());
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
