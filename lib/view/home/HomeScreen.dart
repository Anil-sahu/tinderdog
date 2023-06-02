
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinderdog/RemoteService/getDogs.dart';
import 'package:tinderdog/content.dart';
import 'package:tinderdog/controller/userController.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
   var image ;
var colors=Colors.black;

  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  List<String> _names = [
    "Red",
    "Blue",
    "Green",
    "Yellow",
    "Orange",
    "Grey",
    "Purple",
    "Pink"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];
  var region;
   late AnimationController _favoriteController;
   

  @override
  void initState() {
    Get.find<userController>().getUsername();
    getImage();
      _favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], color: _colors[i]),
          likeAction: () {
           
            setState(() {
              colors=Colors.blue;
            });
          },
          nopeAction: () {

            setState(() {
              colors=Colors.red;
            });
          },
          superlikeAction: () {
     

            setState(() {
              colors=Colors.black;
            });
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");

            setState(() {
this.region = region;
            });
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

getImage()async{
  var img = await RemoteService.fetchDogs();
  setState(() {
    image = img['message'];
  });
}

@override
  void dispose() {
     _favoriteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Obx(()=> Text(Get.find<userController>().username.value)),
          backgroundColor: colors,
          actions: [CircleAvatar(radius: 20,backgroundColor: Colors.white,child: Obx(()=>Text(Get.find<userController>().point.value.toString(),style: TextStyle(color: colors,fontWeight: FontWeight.bold),)),)],
        ),
        body:Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
        
                 Container(
                height: MediaQuery.of(context).size.height-100,
                child: SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: colors,
                      child:image!=null?Image.network(image,width: MediaQuery.of(context).size.width-50,):CircularProgressIndicator(),
                    );
                  },
                  onStackFinished: () {
                    _matchEngine = MatchEngine(swipeItems: _swipeItems);
                    setState(() {
                      
                    });
         
                  },
                  itemChanged: (SwipeItem item, int index) {
                    Get.find<userController>().getUsername();
                    Get.find<userController>().savePoint(Get.find<userController>().point.value+1);
                   
        setState(() {
              getImage();
                 if (_favoriteController.status ==
                          AnimationStatus.dismissed) {
                        _favoriteController.reset();
                        _favoriteController.animateTo(0.6);
                      } else {
                        _favoriteController.reverse();
                      }
                                  if(region ==SlideRegion.inLikeRegion){
colors=Colors.red;
                }
                if(region ==SlideRegion.inNopeRegion){
colors =Colors.blue;
                }
                if(region ==SlideRegion.inSuperLikeRegion){
colors=Colors.black;
                }
        });
                  },
                  leftSwipeAllowed: true,
                  rightSwipeAllowed: true,
                  upSwipeAllowed: true,
                  fillSpace: true,
                  likeTag:Icon(Icons.favorite,color: Colors.yellow,),
                  nopeTag: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red)
                    ),
                    child: Text('Nope'),
                  ),
                  superLikeTag: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange)
                    ),
                    child: Text('Super Like'),
                  ),
                ),
              ),
         
              
         
               
               
        
        
                ],
              ),
             
           

                        Container(
                          child: Container(width: 40,height: 40,decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle),child: Icon(Icons.favorite,color: colors,size: 40,)),
                          height:100,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            boxShadow:[BoxShadow(offset: Offset(2,3),color: Colors.white,blurRadius: 5)],
                            color:Colors.black,borderRadius: BorderRadius.vertical(top: Radius.circular(MediaQuery.of(context).size.width/2)),),),
            ],
            alignment: Alignment.bottomCenter,
          ),
        ));
  }
}