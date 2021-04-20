// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:suuq_somali/anything/anythings_list_details.dart';
// import 'package:suuq_somali/controller/anything_controller.dart';
// import 'package:suuq_somali/utils/app_theme.dart';
//
// import '../DrawerScreen.dart';
//
// class AnythingPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _AnythingPage();
// }
//
// class _AnythingPage extends State<AnythingPage> {
//   final anyThingController = Get.put(AnyThingController());
//   String selectedCategory;
//   bool isValue = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: HexColor("#ededed"),
//
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: Colors.black),
//           backgroundColor: Colors.white,
//           // Here we take the value from the MyHomePage object that was created by
//           // the App.build method, and use it to set our appbar title.
//           title: Image.asset(
//             "assets/images/suuq_logo.png",
//             height: 90,
//             width: 170,
//           ),
//           centerTitle: true,
//         ),
//       drawer: MenuScreen(),
//
//       body: Obx((){
//           if(anyThingController.anyLoading.value){
//             return Center(
//               child: SpinKitChasingDots(
//                 color: Colors.red,
//                 size: 50.0,
//               ),
//             );
//           }
//           return
//             ListView(
//               shrinkWrap: true,
//               primary: false,
//               children: [
//                 anythingPage(),
//               ],
//             );
//         }),
//
//     );
//   }
//
//   Widget anythingPage() {
//     return Column(
//       children: [
//         Container(
//           // height: 470,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/anything.jpg'), fit: BoxFit.cover),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 28.0, bottom: 30),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Wrap(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 25.0),
//                       child: new ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             isValue = true;
//                           });
//                         },
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 isValue ? Colors.red : Colors.black)),
//                         child: Text("    Buy    "),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     new ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           isValue = false;
//                         });
//                       },
//                       style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               isValue ? Colors.black : Colors.red)),
//                       child: Text("    Rent    "),
//                     ),
//                   ],
//                 ),
//
//             Padding(
//                   padding: const EdgeInsets.only(left: 20.0, right: 20),
//                   child: Container(
//                     // height: 360,
//                     // width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.black,
//                     ),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               left: 24, right: 24, top: 23),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: AppTheme.getTheme().backgroundColor,
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(0),
//                               ),
//                               boxShadow: <BoxShadow>[
//                                 BoxShadow(
//                                   color: AppTheme.getTheme().dividerColor,
//                                   blurRadius: 8,
//                                   offset: Offset(4, 4),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 1, right: 16, top: 0),
//                               child: Column(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 8.0, left: 6, right: 5),
//                                     child: TextField(
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         filled: true,
//                                         focusColor: Colors.white,
//                                         fillColor: Colors.white,
//                                         hintText: "Area",
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         Obx(
//                               () {
//                             if (anyThingController.anyLoading.value) {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                             return Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 10.0, left: 25, right: 25),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//
//                                 ),
//                                 child: DropdownButtonHideUnderline(
//                                   child: Container(
//
//                                     child: DropdownButton(
//                                       iconSize: 35,
//                                       icon: Icon(Icons.keyboard_arrow_down_rounded),
//                                       isExpanded: true,
//                                       style: TextStyle(color: Colors.black),
//                                       hint: Padding(
//                                         padding: const EdgeInsets.only(left:12.0),
//                                         child: Text(
//                                           " Select Category",
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ),
//                                       items: anyThingController.getAnything.value.cats.map((e) {
//                                         return DropdownMenuItem(child: Padding(
//                                           padding: const EdgeInsets.only(left:12.0),
//                                           child: Text(e.catName),
//                                         ),value: e.catName,);
//                                       } ).toList(),
//                                       value: selectedCategory,
//                                       onChanged: (text) {
//                                         setState(() {
//                                           selectedCategory = text;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//
//                               ),
//                             );
//                           },
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(
//                               top: 8.0, left: 22, right: 25),
//                           child: TextField(
//                             decoration: InputDecoration(
//                               contentPadding: EdgeInsets.only(left: 18,top: 4),
//                               filled: true,
//                               focusColor: Colors.white,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.white,
//                                 ),
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               hintText: "Where are you looking for...",
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 28.0, right: 28),
//                           child: Container(
//                             height: 50,
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all<Color>(
//                                           Colors.red)),
//                               child: Text(
//                                 "Search",
//                                 style: TextStyle(fontSize: 20),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//
//               ],
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 22.0, left: 54),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Most Popular Categories",
//                 style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         Divider(
//           thickness: 2,
//           color: Colors.grey,
//           indent: 5,
//           endIndent: 5,
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         Container(
//           color: Color(0xededed),
//           child: Obx(() {
//             if (anyThingController.anyLoading.value) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return   GridView.builder(
//
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,),
//               shrinkWrap: true,
//               primary: false,
//               itemCount: anyThingController.getAnything.value.cats.length,
//               itemBuilder: (_, index) {
//                 var anything = anyThingController.getAnything.value.cats[index];
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: InkWell(
//                     onTap: () {
//                        Get.to(AnythingCategoryDetails(cat: anything),transition: Transition.zoom);
//                     },
//                     child: Card(
//                       elevation: 2,
//                       color: Colors.white,
//                       margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Image.network(
//                             anything.catImg,
//                             height: 40,
//                             width: 40,
//                           ),
//                           SizedBox(
//                             height: 9,
//                           ),
//                           Text(
//                             anything.catName,
//                             style: TextStyle(fontSize: 18),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             );
//             // return ListView.builder(
//             //   shrinkWrap: true,
//             //   primary: false,
//             //   itemCount:anyThingController.getAnything.value.cats.length ,
//             //   itemBuilder:(_,index){
//             //     var data =
//             //     anyThingController.getAnything.value.cats[index];
//             //     return ListTile(
//             //       title: Text(data.catName,style: TextStyle(fontSize: 22),),
//             //     );
//             //   },
//             // );
//           }),
//         ),
//       ],
//     );
//   }
// }
