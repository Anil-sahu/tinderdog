import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tinderdog/controller/userController.dart';
import 'package:tinderdog/view/auth/signin.dart';
import 'package:tinderdog/view/home/HomeScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 4);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Get.find<userController>().username.value != "" &&
            Get.find<userController>().username.isNotEmpty
        ? Get.offAll(() =>  MyHomePage())
        : Get.offAll(() => const LoginScreen());
  }

  @override
  void initState() {
    Get.find<userController>().getUsername();
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Image.asset(
        "images/logo.png",
        width: MediaQuery.of(context).size.width / 2,
      )),
    );
  }
}
