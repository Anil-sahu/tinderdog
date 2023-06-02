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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var image;
  var colors = Colors.black;
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  var region;

  late AnimationController _favoriteController;

  getSwiperItem() {
    for (int i = 0; i < 10; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: i.toString(), color: colors),
          likeAction: () {
            setState(() {
              colors = Colors.blue;
              Get.find<userController>()
                  .saveRPoint(Get.find<userController>().rpoint.value + 1);
            });
          },
          nopeAction: () {
            setState(() {
              Get.find<userController>()
                  .saveLPoint(Get.find<userController>().lpoint.value + 1);
              colors = Colors.red;
            });
          },
          superlikeAction: () {
            Get.find<userController>()
                .saveDPoint(Get.find<userController>().dpoint.value + 1);

            setState(() {
              colors = Colors.black;
            });
          },
          onSlideUpdate: (SlideRegion? region) async {
            setState(() {
              this.region = region;
            });
          }));
    }
  }

  getImage() async {
    var img = await RemoteService.fetchDogs();
    setState(() {
      image = img['message'];
    });
  }

  @override
  void initState() {
    Get.find<userController>().getUsername();
    getImage();
    getSwiperItem();
    _favoriteController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
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
          title: Obx(() =>
              Text(Get.find<userController>().username.value.toUpperCase())),
          backgroundColor: colors,
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 100,

                    //----------------------------SWIPE CARDD------------------------------------//
                    child: SwipeCards(
                      matchEngine: _matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: colors,
                          child: image != null
                              ? Image.network(
                                  image,
                                  width: MediaQuery.of(context).size.width - 50,
                                )
                              : const CircularProgressIndicator(),
                        );
                      },
                      onStackFinished: () {
                        _matchEngine = MatchEngine(swipeItems: _swipeItems);
                        setState(() {});
                      },
                      itemChanged: (SwipeItem item, int index) {
                        print(item.decision);
                        Get.find<userController>().getUsername();

                        getImage();
                        if (_favoriteController.status ==
                            AnimationStatus.dismissed) {
                          _favoriteController.reset();
                          _favoriteController.animateTo(0.6);
                        } else {
                          _favoriteController.reverse();
                        }
                        if (region == SlideRegion.inLikeRegion) {
                          colors = Colors.red;
                          Get.find<userController>().saveLPoint(
                              Get.find<userController>().lpoint.value + 1);
                          print(region);
                        }
                        if (region == SlideRegion.inNopeRegion) {
                          colors = Colors.blue;
                          Get.find<userController>().saveRPoint(
                              Get.find<userController>().rpoint.value + 1);
                        }
                        if (region == SlideRegion.inSuperLikeRegion) {
                          colors = Colors.black;
                          Get.find<userController>().saveDPoint(
                              Get.find<userController>().dpoint.value + 1);
                        }
                      },
                      leftSwipeAllowed: true,
                      rightSwipeAllowed: true,
                      upSwipeAllowed: true,
                      fillSpace: true,
                    ),
                  ),
                ],
              ),

              //-----------------------------BOTTOM wIDGET---------------------------//
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2, 3),
                          color: Colors.white,
                          blurRadius: 5)
                    ],
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: colors.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 40,
                            ),
                            Obx(() => Text(
                                  Get.find<userController>()
                                      .lpoint
                                      .value
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.black,
                              size: 40,
                            ),
                            Obx(() => Text(
                                  Get.find<userController>()
                                      .dpoint
                                      .value
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(
                              Icons.favorite,
                              color: Colors.blue,
                              size: 40,
                            ),
                            Obx(() => Text(
                                  Get.find<userController>()
                                      .rpoint
                                      .value
                                      .toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
