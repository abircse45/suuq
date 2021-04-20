import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suuq_somali/animation/FadeAnimation.dart';
import 'package:suuq_somali/anything/anythings_list_details.dart';
import 'package:suuq_somali/car/CarPage.dart';
import 'package:suuq_somali/controller/anything_controller.dart';
import 'package:suuq_somali/property/PropertyPage.dart';
import 'package:suuq_somali/utils/Utility.dart';
import 'package:suuq_somali/utils/app_theme.dart';

import '../DrawerScreen.dart';
import '../home_bottom.dart';

class AnythingPageClone extends StatefulWidget {
  @override
  _AnythingPageCloneState createState() => _AnythingPageCloneState();
}

class _AnythingPageCloneState extends State<AnythingPageClone> {
  final anyThingController = Get.put(AnyThingController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            child: Image.asset(
              "assets/images/car.jpg",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PropertyPage()),
                    );
                  },
                  child: FadeAnimation(
                    0.2,
                    ItemCard("assets/images/real-state.png", "Property"),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CarPage()),
                    );
                  },
                  child: FadeAnimation(
                    0.2,
                    ItemCard("assets/images/car.png", "Car"),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: HexColor("#ededed"),
            child: Obx(
              () {
                if (anyThingController.anyLoading.value) {
                  return Center(
                    child: SpinKitChasingDots(
                      color: Colors.red,
                      size: 40.0,
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: anyThingController.getAnything.value.cats.length,
                  itemBuilder: (_, index) {
                    var anything =
                        anyThingController.getAnything.value.cats[index];
                    return InkWell(
                      onTap: () {
                        Get.to(AnythingCategoryDetails(cat: anything),
                            transition: Transition.zoom);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 7.0, right: 7.0, top: 8.0, bottom: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          height: 150,
                          width: 500,
                          child: Material(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      height: 60,
                                      width: 60,
                                      image: NetworkImage(
                                        anything.catImg,
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      child: Text(
                                        anything.catName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                    //   ClipRRect(
                    //   borderRadius: BorderRadius.circular(20),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Get.to(AnythingCategoryDetails(cat: anything),
                    //           transition: Transition.zoom);
                    //     },
                    //     child:  Card(
                    //         elevation: 2,
                    //         color: Colors.white,
                    //         margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    //         child: Column(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Image.network(
                    //
                    //               anything.catImg,
                    //               height: 40,
                    //               width: 40,
                    //             ),
                    //             SizedBox(
                    //               height: 9,
                    //             ),
                    //             Padding(
                    //              padding: EdgeInsets.only(left: 8,right: 8),
                    //               child: Text(
                    //                 anything.catName,
                    //                 style: TextStyle(fontSize: 18),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //
                    // );
                  },
                );
              },
            ),
          ),

          SizedBox(height: 240,),


        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  String image, title;

  ItemCard(this.image, this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 7.0, right: 7.0, top: 8.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        height: 150,
        width: 500,
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 60,
                    width: 60,
                    color: Colors.black,
                    image: AssetImage(
                      image,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
