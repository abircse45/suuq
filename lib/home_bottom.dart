//
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:suuq_somali/anything/AnythingPage.dart';
// import 'package:suuq_somali/car/CarPage.dart';
// import 'package:suuq_somali/property/PropertyPage.dart';
// import 'package:suuq_somali/screen/Home_screen.dart';
// import 'package:suuq_somali/screen/my_profile.dart';
// import 'package:suuq_somali/utils/Utility.dart';
//
// class HomeBottom extends StatefulWidget {
//  final int form;
//
//   HomeBottom( this.form);
//   @override
//   _HomeBottomState createState() => _HomeBottomState();
// }
//
// class _HomeBottomState extends State<HomeBottom> {
//   // Properties & Variables needed
//
//
//   int currentTab = 0; // to keep track of active tab index
//   final List<Widget> screens = [
//     MyHomePage(),
//     PropertyPage(),
//     CarPage(),
//     AnythingPage(),
//   ]; // to store nested tabs
//   final PageStorageBucket bucket = PageStorageBucket();
//   Widget currentScreen = MyHomePage(); // Our first view in viewport
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageStorage(
//         child: currentScreen,
//         bucket: bucket,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.red,
//         child: Icon(Icons.add),
//         onPressed: () {},
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         //shape: CircularNotchedRectangle(),
//         //notchMargin: 10,
//         child: Container(
//           height: 60,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//
//
//
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             MyHomePage(); // if user taps on this dashboard tab will be active
//                         currentTab = Utility.HOMEBOTTOMTAB;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//
//                           Icons.home,
//                           color: currentTab == 0 ? Colors.red : Colors.grey,
//                           size: 25,
//                         ),
//                         Text(
//                           'Home',
//                           style: TextStyle(
//                             color: currentTab == 0 ? Colors.grey : Colors.grey,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
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
//                             PropertyPage(); // if user taps on this dashboard tab will be active
//                         currentTab = Utility.PROPERTY;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//
//                           Icons.account_balance,
//                           color: currentTab == 1 ? Colors.red : Colors.grey,
//                           size: 25,
//                         ),
//                         Text(
//                           'Property',
//                           style: TextStyle(
//                             color: currentTab == 1 ? Colors.grey : Colors.grey,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
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
//                             CarPage(); // if user taps on this dashboard tab will be active
//                         currentTab = Utility.CAR;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           FontAwesomeIcons.car,
//                           color: currentTab == 2 ? Colors.red : Colors.grey,
//                           size: 25,
//                         ),
//                         Text(
//                           'Car',
//                           style: TextStyle(
//                             color: currentTab == 2 ? Colors.grey : Colors.grey,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   MaterialButton(
//                     minWidth: 40,
//                     onPressed: () {
//                       setState(() {
//                         currentScreen =
//                             AnythingPage(); // if user taps on this dashboard tab will be active
//                         currentTab = Utility.ANYTHING;
//                       });
//                     },
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.shopping_cart,
//                           size: 25,
//                           color: currentTab == 3 ? Colors.red : Colors.grey,
//                         ),
//                         Text(
//                           'Market',
//                           style: TextStyle(
//                             color: currentTab == 3 ? Colors.grey : Colors.grey,
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuq_somali/car/CarPage.dart';
import 'package:suuq_somali/property/PropertyPage.dart';
import 'package:suuq_somali/screen/Home_screen.dart';
import 'package:suuq_somali/utils/Utility.dart';
import 'package:suuq_somali/utils/app_theme.dart';

import 'anything/AnythingPage.dart';

class HomeBottom extends StatefulWidget {
  int from;

  HomeBottom(this.from);

  @override
  State<StatefulWidget> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottom> {
  int currentIndex;

  Widget callPage(int page) {
    print("page: $page");
    switch (page) {
      case 0:
        return MyHomePage();
        break;
      case 1:
        return PropertyPage();
        break;
      case 2:
        return CarPage();
        break;
    default:
    // return AnythingPage();
    break;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.from;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
       FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){},
          backgroundColor:        HexColor("#dc3545"),


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: callPage(currentIndex),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Color(0xFFFFFFFF),
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white.withOpacity(0.5)))),
        child: BottomNavigationBar(

          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: (value) {
            currentIndex = value;
            debugPrint("current index: $currentIndex");
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,
                    size: 30,
                    color: currentIndex == Utility.HOMEBOTTOMTAB
                        ?   HexColor("#dc3545")
                        : Colors.grey),
                label: 'Home'),

            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(right:38.0),
                  child: Icon(Icons.account_balance,
                      size: 25,
                      color: currentIndex == Utility.PROPERTY
                          ? HexColor("#dc3545")
                          : Colors.grey),
                ),
                label: 'Property         '),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(left:38.0),
                  child: Image.asset("assets/images/car.png",
                      height: 30,
                      width: 30,
                      color: currentIndex == Utility.CAR
                          ? HexColor("#dc3545")
                          : Colors.grey),
                ),
                label: '             Car'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart,
                    size: 30,
                    color: currentIndex == Utility.ANYTHING
                        ? HexColor("#dc3545")
                        : Colors.grey),
                label: 'Market'),

          ],
        ),
      ),
    );
  }
}
