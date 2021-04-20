import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:suuq_somali/screen/anything_screen_clone.dart';
import 'package:suuq_somali/screen/searchList_category.dart';
import 'package:suuq_somali/utils/app_theme.dart';

class MarketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                Expanded(
                  child: IntrinsicHeight(
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_location,
                            color: Colors.lightGreen,
                          ),
                          Text(
                            " Location",
                            style: TextStyle(fontSize: 15),
                          ),
                          VerticalDivider(
                            color: Colors.grey[800],
                            width: 50,
                            thickness: 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IntrinsicHeight(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(
                          SearchListCategory(),
                          transition: Transition.zoom,
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_sharp,
                            color: Colors.lightGreen,
                          ),
                          Text(
                            " Category",
                            style: TextStyle(fontSize: 15),
                          ),
                          VerticalDivider(
                            color: Colors.grey[800],
                            width: 50,
                            thickness: 0.2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 18.0,
                  ),
                  child: IconButton(
                      icon: Icon(Icons.filter_list_outlined,
                          color: Colors.lightGreen),
                      onPressed: () {}),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            color: HexColor("#ededed"),
            height: MediaQuery.of(context).size.height,
            child: DefaultTabController(
              // initialIndex: 1,
              length: 3,
              child: Scaffold(
                backgroundColor: HexColor("#ededed"),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  toolbarHeight: 50,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.red,
                    indicatorWeight: 2,
                    labelStyle: TextStyle(fontSize: 15),
                    tabs: <Widget>[
                      Tab(
                        text: "Categories",
                        // child: Container(
                        //   child: Text(
                        //     "Categories",
                        //     style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                      ),
                      Tab(
                        text: "Ads",
                        // child: Text(
                        //   "Ads",
                        //   style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                        // ),
                      ),
                      Tab(
                        text: "Viewed",
                        // child: Text(
                        //   "Viewed",
                        //   style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
                        // ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    AnythingPageClone(),
                    Center(
                      child: Text('Ads'),
                    ),
                    Center(
                      child: Text('Viewed'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
