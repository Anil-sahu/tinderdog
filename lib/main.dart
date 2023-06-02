
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/flutter_animated_icons.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:get/get.dart';

import 'package:tinderdog/controller/userController.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tinderdog/view/auth/signin.dart';
import 'package:tinderdog/view/splashScreen.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );
Get.lazyPut(()=>userController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Get.find<userController>().getUsername();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tindere dog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
