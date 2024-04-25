import 'package:flutter/material.dart';
import 'package:flutter_application_sqlite/view/screens/home_screen.dart';
import 'package:flutter_application_sqlite/view/screens/splash_screen.dart';

void main() {
  runApp(MyRestaurant());
}

class MyRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
