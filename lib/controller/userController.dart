import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userController extends GetxController{
  var username="".obs;
  var point =0.obs;
@override
  onInit(){
super.onInit();
getPoint();
getUsername();
  }

  savename(username)async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setString('username', username);

  }
  getUsername()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
username.value =prefs.getString("username")??"";
print(username.value);
  }
  savePoint(point)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setInt('point',point);
getPoint();
  }

  getPoint()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
point.value =prefs.getInt("point")??0;
  }
  
}