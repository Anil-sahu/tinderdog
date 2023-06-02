import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class userController extends GetxController{
  var username="".obs;
  var dpoint =0.obs;
  var lpoint =0.obs;
  var rpoint =0.obs;
@override
  onInit(){
super.onInit();
getDPoint();
getLPoint();
getRPoint();
getUsername();
  }

//-----------------------------SAVE USERNAME ---------------------------------------//
  savename(username)async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setString('username', username);

  }

  //---------------------------GET USERNAME-----------------------------------------//
  getUsername()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
username.value =prefs.getString("username")??"";

  }

  //---------------------------------SAVE DOWN SLIDE POINT---------------------------//
  saveDPoint(point)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setInt('Dpoint',point);
getDPoint();
  }


//----------------------------------------GET DOWN SLIDE POINT-------------------------//
  getDPoint()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
dpoint.value =prefs.getInt("Dpoint")??0;

  }

//----------------------------------SAVE LEFT SLIDE PPOINT-----------------------------//
   saveLPoint(point)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setInt('Lpoint',point);
getLPoint();
  }


//------------------------------GET LEFT SLIDE POINT----------------------------------------//
  getLPoint()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
lpoint.value =prefs.getInt("Lpoint")??0;

  }

//------------------------------------SAVE RIGHT SLIDE POINT-----------------------------------//
   saveRPoint(point)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setInt('Rpoint',point);
getRPoint();
  }


//----------------------------------------------GET RIGHT SLIDE POINT----------------------------//
  getRPoint()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
rpoint.value =prefs.getInt("Rpoint")??0;

  }
  
}