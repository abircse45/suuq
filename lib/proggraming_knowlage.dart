// import 'package:flutter/material.dart';
// import 'package:suuq_somali/car/proggram_car.dart';
// import 'package:suuq_somali/models/car_model.dart';
//
// class ProggramingKnowlwgw extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     final allListData = bikes.map((e){
//       final data = e.name;
//       return Text(data);
//     });
//     final containsData = cars.contains("Abr");
//     final carDataList = cars.map((e){
//       var car = e;
//
//       return Text(car);
//     });
//
//     final carsReduce = cars.reduce((value, element) => '$value'  "$element");
//
//     final filterBike = bikes.where((element) =>
//       // ignore: unnecessary_statements
//       element.name.length <=  5,
//     );
//
//     final bikesStratWith = cars.where((element) => element.startsWith("p"));
//
//     final takeIt = bikes.take(2);
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Program"),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListView(
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   cars.forEach((element) {
//                     print(element);
//                   });
//                 },
//                 child: Text("For Each"),
//               ),
//            ...allListData,
//
//               SizedBox(height: 30,),
//
//                 containsData ? Text("Abir") : Text("None"),
//               ...carDataList,
//               SizedBox(height: 30,),
//
//           Text("$carsReduce"),
//
//               SizedBox(height: 30,),
//               ...filterBike.map((e) => Text(e.name)).toList(),
//
//
//               ...bikesStratWith.map((e) => Text(e)),
//
//               ...takeIt.map((e) => Text(e.name)).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:bottom_tab_app/pages/profile.dart';
// import 'package:bottom_tab_app/pages/settings.dart';
// import 'package:flutter/material.dart';
//
// import 'chat.dart';
// import 'dashboard.dart';
//
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   // Properties & Variables needed
//
//   int currentTab = 0; // to keep track of active tab index
//   final List<Widget> screens = [
//     Dashboard(),
//     Chat(),
//     Profile(),
//     Settings(),
//   ]; // to store nested tabs
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = Dashboard(); // Our first view in viewport
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(
//         child: currentScreen,
//         bucket: bucket,
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: CircularNotchedRectangle(),
//         notchMargin: 10,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             Dashboard(); // if user taps on this dashboard tab will be active
//                         currentTab = 0;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.dashboard,
//                           color: currentTab == 0 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Dashboard',
//                           style: TextStyle(
//                             color: currentTab == 0 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             Chat(); // if user taps on this dashboard tab will be active
//                         currentTab = 1;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.chat,
//                           color: currentTab == 1 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Chats',
//                           style: TextStyle(
//                             color: currentTab == 1 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//
//               // Right Tab bar icons
//
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             Profile(); // if user taps on this dashboard tab will be active
//                         currentTab = 2;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.dashboard,
//                           color: currentTab == 2 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Profile',
//                           style: TextStyle(
//                             color: currentTab == 2 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             Settings(); // if user taps on this dashboard tab will be active
//                         currentTab = 3;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.chat,
//                           color: currentTab == 3 ? Colors.blue : Colors.grey,
//                         ),
//                         Text(
//                           'Settings',
//                           style: TextStyle(
//                             color: currentTab == 3 ? Colors.blue : Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
