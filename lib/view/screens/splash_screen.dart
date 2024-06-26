import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/global_consts.dart';
import '../widgets/auth_widgets/popup_authwidget.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextView();
  }

  void goToNextView() {
    Future.delayed(Duration(seconds: 3), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var username = prefs.getString("username");
      log(username.toString());
      username == null
          ? Navigator.of(context).push(AuthPopUp<void>())
          : Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scafoldcolor,
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: Image.asset(
              'assets/app_images/splash2.jpg',
              fit: size.width < 480 ? BoxFit.fitHeight : BoxFit.contain,
            ),
          ),
          Positioned(
              top: size.height * .48,
              left: size.width * .48,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
