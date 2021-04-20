import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:suuq_somali/DrawerScreen.dart';
import 'package:suuq_somali/animation/FadeAnimation.dart';
import 'package:suuq_somali/controller/property_controller.dart';
import 'package:suuq_somali/controller/search_controller.dart';
import 'package:suuq_somali/models/all_ads_model.dart';
import 'package:suuq_somali/property/property_details.dart';
import 'package:suuq_somali/screen/search_screen.dart';
import 'package:suuq_somali/utils/app_theme.dart';

import 'lastest_listings_details.dart';

class PropertyPage extends StatefulWidget {
  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage>
    with TickerProviderStateMixin {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => menuController,
      child: ScreenHomePage(
        menuScreen: MenuScreen(),
        contentScreen: Layout(
            contentBuilder: (cc) => Container(
                  color: Colors.grey[200],
                  child: Container(
                    color: Colors.grey[200],
                  ),
                )),
      ),
    );
  }
}

class ScreenHomePage extends StatefulWidget {
  final Widget menuScreen;
  final Layout contentScreen;

  ScreenHomePage({
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ScreenHomePageState createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage> {
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  var now = new DateTime.now();
  var formatter = new DateFormat('MM');

  createContentDisplay() {
    return zoomAndSlideContent(
      new Container(
        child: new Scaffold(
          backgroundColor: HexColor("#ededed"),

          // backgroundColor: Colors.white,

          // Calling variable appbar
          appBar: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0.0,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Image.asset(
                "assets/images/suuq_logo.png",
                height: 90,
                width: 170,
              ),
            ),
            leading: new IconButton(
                icon: Icon(
                  EvaIcons.menu2Outline,
                  color: Colors.black,
                ),
                onPressed: () {
                  Provider.of<MenuController>(context, listen: false).toggle();
                }),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child:
                    InkWell(onTap: () {}, child: Icon(EvaIcons.personOutline)),
              ),
            ],
          ),
          body: Obx(() {
            if (propertyController.loading.value) {
              return  Center(
                child: SpinKitChasingDots(
                  color: Colors.red,
                  size: 50.0,
                ),
              );
            }
            return ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                showProperty(),
              ],
            );
          }),
        ),
      ),
    );
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;

    switch (Provider.of<MenuController>(context, listen: true).state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        scalePercent = scaleDownCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        scalePercent = scaleUpCurve.transform(
            Provider.of<MenuController>(context, listen: true).percentOpen);
        break;
    }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius =
        16.0 * Provider.of<MenuController>(context, listen: true).percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }

  final propertyController = Get.put(PropertyController());
  final searchController = Get.put(SearchController());

  bool isVisible = false;
  //List<String> datType = [];
  String buycat_id = "173";
  String propertyRent = "173";
  String propertyBuy = "174";
  String selectArea;
  String selectProperty;
  String selectedRoom;
  String selectBathRooms;
  String selectedCarSpace;
  AutoCompleteTextField searchTextField;
  String selectedCity;
  bool isChange;

  GlobalKey<AutoCompleteTextFieldState<StateValue>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Scaffold(
            body: widget.menuScreen,
          ),
        ),
        createContentDisplay()
      ],
    );
  }

  Widget showProperty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: 470,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/hero.jpeg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, bottom: 5),
                  child: Wrap(
                    children: [
                      RaisedButton(

                        color:  Colors.black,
                        onPressed: () {

                        },
                        child: Text("Rent",style: TextStyle(fontSize: 16,color: Colors.white),),
                      ),

             
                      SizedBox(
                        width: 10,
                      ),
                      RaisedButton(
                        color:  Colors.red ,
                        onPressed: () {

                        },
                        child: Text("Buy",style: TextStyle(fontSize: 16,color: Colors.white),),

                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    // height: 360,
                    // width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black,
                    ),
                    child: Column(
                      children: [
                        Obx(() {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 23.0, right: 23.0, top: 18),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white),
                              child: SearchableDropdown(
                                hint: Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: Text("Select City"),
                                ),
                                iconSize: 20,
                                displayClearIcon: true,
                                underline: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                ),
                                items: propertyController
                                    .getProperty.value.states.values
                                    .map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.stateName),
                                    value: e.stateName,
                                  );
                                }).toList(),
                                value: selectedCity,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value;
                                  });
                                },
                                isExpanded: true,
                              ),
                            ),
                          );
                        }),

                        ///Pending......

                        Obx(
                          () {
                            if (propertyController.loading.value) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 25, right: 25),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    underline: Container(
                                      height: 1,
                                      color: Colors.transparent,
                                    ),
                                    iconSize: 30,
                                    isExpanded: true,
                                    style: TextStyle(color: Colors.black),
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        " Select Area",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items: propertyController
                                        .getProperty.value.cities.values
                                        .map((e) {
                                      return DropdownMenuItem(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: Container(
                                            child: ListTile(
                                              title: Text(e.cityName),
                                            ),
                                          ),
                                        ),
                                        value: e.cityName,
                                      );
                                    }).toList(),
                                    value: selectArea,
                                    onChanged: (text) {
                                      setState(() {
                                        selectArea = text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        //  Area ////////

                        Obx(
                          () {
                            if (propertyController.loading.value) {
                              return  Center(
                                child: SpinKitChasingDots(
                                  color: Colors.red,
                                  size: 50.0,
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, left: 25, right: 25),
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    iconSize: 35,
                                    isExpanded: true,
                                    style: TextStyle(color: Colors.black),
                                    hint: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        " Select Property Type",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    items: propertyController.propertyList
                                        .map((element) {
                                      return DropdownMenuItem(
                                        value: element,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 17.0),
                                          child: Text(
                                            element,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: selectProperty,
                                    onChanged: (text) {
                                      setState(() {
                                        selectProperty = text;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 28.0, right: 28),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                searchController.getSaerchDataCalling(
                                  buycat_id,
                                  selectedCity,
                                  selectArea,
                                  selectProperty,
                                  selectedCarSpace,
                                  selectBathRooms,
                                  selectedRoom,
                                );
                                // searchController.searchService.fetchSearchData(
                                //   buycat_id,
                                //   selectedCity,
                                //   selectArea,
                                //   selectProperty,
                                //   selectedCarSpace,
                                //   selectBathRooms,
                                //   selectedRoom,
                                //
                                //
                                //
                                // );
                                Get.to(SearchScreen(),
                                    transition: Transition.zoom);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                              ),
                              child: Text(
                                "Search",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      "Advance Search",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ),
                                  Icon(
                                    isVisible
                                        ? Icons.keyboard_arrow_down_rounded
                                        : Icons.keyboard_arrow_up_outlined,
                                    color: Colors.white,
                                  ),
                                  // Spacer(),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 30.0),
                                  //   child: Text(
                                  //     "Reset Search",
                                  //     style: TextStyle(
                                  //         fontSize: 14, color: Colors.white),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            TextButton(
                              onPressed: () {
                                // setState(() {
                                //   // selectArea = '';
                                //   // selectProperty = '';
                                //   // selectBathRooms = '';
                                //   // selectedCarSpace = '';
                                //   // selectedRoom = '';
                                //   // selectedValue = '';
                                // });
                              },
                              child: Text(
                                "Reset Search",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: isVisible,
                          child: Column(
                            children: [
                              //Rooms......Advance Search......
                              Obx(
                                () {
                                  if (propertyController.loading.value) {
                                    return  Center(
                                      child: SpinKitChasingDots(
                                        color: Colors.red,
                                        size: 50.0,
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 25, right: 25),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          style: TextStyle(color: Colors.black),
                                          hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              "Rooms",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          items: propertyController.roomList
                                              .map((element) {
                                            return DropdownMenuItem(
                                              value: element,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0),
                                                child: Text(
                                                  element,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          value: selectedRoom,
                                          onChanged: (text) {
                                            setState(() {
                                              selectedRoom = text;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Obx(
                                () {
                                  if (propertyController.loading.value) {
                                    return  Center(
                                      child: SpinKitChasingDots(
                                        color: Colors.red,
                                        size: 50.0,
                                      ),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 25, right: 25),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          style: TextStyle(color: Colors.black),
                                          hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              "BathRooms",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          items: propertyController.bathRooms
                                              .map((element) {
                                            return DropdownMenuItem(
                                              value: element,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0),
                                                child: Text(
                                                  element,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          value: selectBathRooms,
                                          onChanged: (text) {
                                            setState(() {
                                              selectBathRooms = text;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Obx(
                                () {
                                  if (propertyController.loading.value) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 25, right: 25),
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isExpanded: true,
                                          style: TextStyle(color: Colors.black),
                                          hint: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0),
                                            child: Text(
                                              "Car Space",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          items: propertyController.carSpace
                                              .map((element) {
                                            return DropdownMenuItem(
                                              value: element,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 13.0),
                                                child: Text(
                                                  element,
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          value: selectedCarSpace,
                                          onChanged: (text) {
                                            setState(() {
                                              selectedCarSpace = text;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 23.0, top: 10),
                                          child: Container(
                                            height: 70,
                                            width: double.infinity,
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.only(left: 59),
                                                filled: true,
                                                focusColor: Colors.white,
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                hintText: "0",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 21, top: 10),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 18.0),
                                            child: Container(
                                              height: 70,
                                              width: double.infinity,
                                              child: TextFormField(
                                                // controller: passportTourController,
                                                // //     controller: _controllers3[index],
                                                //

                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(left: 49),
                                                  filled: true,
                                                  focusColor: Colors.white,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  hintText: "100",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Featured Listing",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
          color: Colors.grey,
          indent: 12,
          endIndent: 5,
        ),
        //  Feature Listing....................
        Obx(() {
          if (propertyController.loading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: 335,
            //  width: 260,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: propertyController.getProperty.value.featured.length,
              itemBuilder: (_, index) {
                var data = propertyController.getProperty.value.featured[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 7.0, top: 5),
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              PropertyDetails(
                                image: data.photoUrl,
                                title: data.listingTitle,
                                price: data.price,
                                description: data.shortDesc,
                                listingAddress: data.listingAddr,
                                catNamePropertyForBuy: "${data.catName}",
                                propertyType: data.customFields['32'],
                                bathrooms: data.customFields['34'],
                                buildYear: data.customFields['39'],
                                enterHouseSize: data.customFields['38'],
                                rooms: data.customFields['33'],
                                carSpace: data.customFields['37'],
                              ),
                              transition: Transition.zoom);
                        },
                        child: Container(
                          height: 360,
                          width: 260,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    data.photoUrl,
                                    height: 138,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 98.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0, right: 30),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                  "\$${data.price}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  data.listingTitle,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: Colors.red,
                                                  ),
                                                  Text("1 month ago"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.tour,
                                                    color: Colors.red,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        "Beds:${data.customFields['33']}"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.keyboard,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                      "Type:${data.customFields['32']}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.start,
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  Text(data.stateAbbr),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, right: 5),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 3.0),
                                                      child: Icon(
                                                        Icons.adb_sharp,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                        "Bath:${data.customFields['34']}"),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0, right: 3),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.border_style,
                                                      color: Colors.red,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Text(
                                                          "sq.ft${data.customFields['38'] ?? ""}"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),

                              ///  property  Call
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Text(
                                      "Property for Buy",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.red[600],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 5.0),
                                    child: new ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.black)),
                                      child: Text("    Call    "),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
        SizedBox(
          height: 20,
        ),
        // Explore The Latest Listings...
        Padding(
          padding: const EdgeInsets.only(top: 12.0, left: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Explore The Latest Listing",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
          color: Colors.grey,
          indent: 12,
          endIndent: 5,
        ),
        Obx(() {
          if (propertyController.loading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            height: 332,
            //  width: 260,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: propertyController.getProperty.value.latest.length,
              itemBuilder: (_, index) {
                var latestData =
                    propertyController.getProperty.value.latest[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 7.0, top: 5),
                  child: Card(
                    color: Colors.white,
                    elevation: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          Get.to(
                              DetailsLatestListing(
                                image: latestData.photoUrl,
                                title: latestData.listingTitle,
                                price: latestData.listingPrice,
                                description: latestData.shortDesc,
                                listingAddress: latestData.listingAddr,
                                catNamePropertyForBuy:
                                    latestData.catName.toString(),
                                propertyType: latestData.customFields['32'],
                                bathrooms: latestData.customFields['34'],
                                buildYear: latestData.customFields['39'],
                                enterHouseSize: latestData.customFields['38'],
                                rooms: latestData.customFields['33'],
                                carSpace: latestData.customFields['37'],
                              ),
                              transition: Transition.zoom);

                          //   Get.to(PropertyDetails(), transition: Transition.zoom);
                        },
                        child: Container(
                          height: 362,
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    latestData.photoUrl,
                                    height: 138,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 98.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 0.0, right: 30),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: Text(
                                                  "\$ ${latestData.listingPrice}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              )),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            icon: Icon(
                                              Icons.favorite_border,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "${latestData.listingTitle}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: Colors.red,
                                                  ),
                                                  Text("1 month ago"),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.tour,
                                                    color: Colors.red,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                        "Beds:${latestData.customFields['33']}"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.keyboard,
                                                    color: Colors.red,
                                                  ),
                                                  Text(
                                                      "Type:${latestData.customFields['32']}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.start,
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.red,
                                                  ),
                                                  Text(latestData.stateAbbr),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0, right: 5),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 3.0),
                                                      child: Icon(
                                                        Icons.adb_sharp,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                        "Bath:${latestData.customFields['34']}"),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 2.0, right: 3),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.border_style,
                                                      color: Colors.red,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0),
                                                      child: Text(
                                                          "sq.ft${latestData.customFields['38']}"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.red),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Text(
                                            "Property for Buy",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 6.0, top: 6, bottom: 2),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      right: 15),
                                                  child: Icon(
                                                    Icons
                                                        .phone_enabled_outlined,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "    Call",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class itemCard extends StatelessWidget {
  String image, title;

  itemCard({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      child: Container(
        height: 140.0,
        width: 400.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Material(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFABABAB).withOpacity(0.7),
                  blurRadius: 4.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: Colors.black12.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    shadows: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 10.0,
                          spreadRadius: 2.0)
                    ],
                    color: Colors.white,
                    fontFamily: "Sofia",
                    fontWeight: FontWeight.w800,
                    fontSize: 39.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }) : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }
        notifyListeners();
      });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

class Layout {
  final WidgetBuilder contentBuilder;

  Layout({
    this.contentBuilder,
  });
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}
