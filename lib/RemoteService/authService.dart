import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tinderdog/controller/userController.dart';
import 'package:tinderdog/view/home/HomeScreen.dart';

class AuthonticationService {


  
  //---------------------------------------------------toast--------------------------------------//
   static toast(text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: Colors.white,
      fontSize: 16.0);
}
  
  
  //----------------------------add new user to firestore-----------------------------------//
 static uploadUser(id, username) async {
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(id)
          .set({"name":username})
          .whenComplete(() {
        toast("user added successfull");
      }).onError((error, stackTrace) {
    toast(error.toString());
      });
    } catch (e) {
      toast(e.toString());
    }
  }
//--------------------------get user---------------------------//
  static getUser(id) async {
   await FirebaseFirestore.instance.collection("user").doc(id).get().then((value){
    print(value.data()!['name']);
Get.find<userController>().savename(value.data()!['name']);
    });
     
      
  
  }

//---------------------------------LOGIN USER--------------------------------------//
  static Future<void> login(email, password) async {
    try {
      if (email != null &&
          email.toString().isNotEmpty &&
          password != null &&
          password.toString().isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email!, password: password!)
            .then((value) async {})
            .whenComplete(() async {
          getUser(FirebaseAuth.instance.currentUser!.uid);
          Get.offAll(() => MyHomePage());
        }).onError((error, stackTrace) {
          toast(error.toString());
        });
      } else {
        toast("Email or Password should Not be empty");
      }
    } catch (e) {
      toast(e.toString());
    }
  }



  //---------------------------------CREATE USER--------------------------------------//

  static Future<void> registerUser(name,email,password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email!, password: password!)
        .then((value) async {})
        .whenComplete(() async {
    
      uploadUser(
          FirebaseAuth.instance.currentUser!.uid, name);
      getUser(FirebaseAuth.instance.currentUser!.uid);
      Get.offAll(() =>  MyHomePage());
    }).onError((error, stackTrace) {
      toast(error.toString());
    });
  }


}
