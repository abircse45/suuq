import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suuq_somali/main.dart';
import 'file:///D:/suuqsomali/lib/Profile/update_profile_screen.dart';
import 'package:suuq_somali/utils/app_theme.dart';

import '../DrawerScreen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String firstName;
  String lastName;
  String email;
  String profileImage;
  int id = 0;

  Future<String> getUserData() async {
    print("Get usewr daTA");
    // set User Data....>>>>
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    firstName = sharedPreferences.getString('first_name');
    lastName = sharedPreferences.getString('last_name');
    email = sharedPreferences.getString('email');
    profileImage = sharedPreferences.getString("photo");

    print("SharedData>>>>${sharedPreferences.getString('firstName')}");

    setState(() {});
  }


  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    profileImage = sharedPreferences.getString("photo");
    // token = sharedPreferences.getString("token");
  }

  Future<String> logOut() async {
    SharedPreferences sharedPreferces = await SharedPreferences.getInstance();
    String token = sharedPreferces.getString('loggedin_token');
    if (token != null) {
      await sharedPreferces.clear();
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashScreen()));
      return token;
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getToken();
    // logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/suuq_logo.png",
          height: 90,
          width: 170,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                size: 30,
              ),
              onPressed: () {}),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: MenuScreen(),
      body:     SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18.0, top: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 50.0,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 47.0,
                          backgroundImage: profileImage == null
                              ? AssetImage("assets/images/person.png")
                              : NetworkImage(
                            "",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 29.0,top: 10),
                  child: Column(
                    children: [
                      Text(
                        "Name : $firstName $lastName",
                        style: TextStyle(
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                Padding(
                  padding: const EdgeInsets.only(left: 29.0, top: 4),
                  child: Text(
                    "Email : $email",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                //Spacer(),
                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(left:28.0,right: 28,top: 20),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Area",
                      border: OutlineInputBorder(

                      ),

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:28.0,right: 28,top: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Country",
                      border: OutlineInputBorder(

                      ),

                    ),
                  ),
                ),

                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, bottom: 8, top: 16),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color:HexColor("#dc3545"),
                      borderRadius:
                      BorderRadius.all(Radius.circular(24.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.getTheme().dividerColor,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                        BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.to(ProfileUpdate(),transition: Transition.zoom);
                        },
                        child: Center(
                          child: Text(
                            "Update Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //  Spacer(),

          ],
        ),


      ),
      // Stack(
      //   children: [
      //     Positioned(
      //       top: 80,
      //       child: Card(
      //         elevation: 1,
      //         child: Container(
      //           height: 200,
      //           width: MediaQuery.of(context).size.width * 0.9,
      //           decoration: BoxDecoration(
      //               border: Border.all(
      //                   width: 2, color: Colors.grey[300]),
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(25),
      //               boxShadow: [
      //                 BoxShadow(
      //                   color: Colors.grey.withOpacity(0.3),
      //                   spreadRadius: 0.3,
      //                   blurRadius: 4,
      //                   offset: Offset(0, 9), // changes position of shadow
      //                 ),
      //               ]),
      //           child: Stack(
      //             // ignore: deprecated_member_use
      //             overflow:
      //             // ignore: deprecated_member_use
      //             Overflow.visible,
      //             alignment: Alignment.topCenter,
      //             children: [
      //               Positioned(
      //                 top: -55,
      //                 child: Container(
      //                   height: 100,
      //                   width: 100,
      //                   decoration: BoxDecoration(
      //                       border:
      //                       Border.all(color: Colors.purple, width: 3.0),
      //                       borderRadius:
      //                       BorderRadius.all(Radius.circular(100))),
      //                   child: CircleAvatar(
      //                     radius: 50,
      //                     backgroundImage: NetworkImage(
      //                       "https://wwwimage-us.pplusstatic.com/thumbnails/photos/w425-q80/cast/cast_manwithaplan_mattleblanc.jpg",
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //               Column(
      //                 children: [
      //                   SizedBox(height: 60),
      //                   Container(
      //                     width: MediaQuery.of(context).size.width,
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //
      //                           children: [
      //                             Text(
      //                               "Abir",
      //                               style: TextStyle(
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 18,
      //                                   color: Colors.black),
      //                             ),
      //                             SizedBox(width: 5),
      //                             Text(
      //                               "Hasan",
      //                               style: TextStyle(
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 18,
      //                                   color: Colors.black),
      //                             ),
      //                           ],
      //                         ),
      //                         SizedBox(height: 5,),
      //                         Text(
      //                           "abir.codeware@gmail.com",
      //                           style: TextStyle(
      //                               fontWeight: FontWeight.w600,
      //                               fontSize: 18,
      //                               color: Colors.black),
      //                         ),
      //                         SizedBox(height: 18),
      //                         Container(
      //                           height: 1,
      //                           width: MediaQuery.of(context).size.width,
      //                           decoration: BoxDecoration(
      //                             color: Colors.grey,
      //                           ),
      //                         ),
      //                         SizedBox(height: 10),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               Positioned(
      //                 right: 10,
      //                 child: IconButton(
      //                     icon: Icon(
      //                       Icons.edit,
      //                       color: Colors.black,
      //                       size: 26,
      //                     ),
      //                     onPressed: () {}),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //
      //   ],
      // ),


    );
  }

  _dialogLogOut() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(('Logout!')),
          content: Text(('Do you want to logout?')),
          actions: <Widget>[
            FlatButton(
              child: Text(
                ('No'),
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            FlatButton(
              child: Text(
                ('Yes'),
                style: TextStyle(color: Colors.indigo[800]),
              ),
              onPressed: () {
                logOut();
              },
            )
          ],
        );
      },
    );
  }

  Widget appBar() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => EditProfile(),
        //     fullscreenDialog: true,
        //   ),
        // );
      },
    );
  }
}

//
// import 'dart:io';
// import 'dart:ui';
// import 'package:famouse_live/models/usermodeltwo.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'login_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   _ProfileScreenState();
//
//   getProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     String url = "https://test.iqbal.live/api/user/profile";
//     Map<String, String> requestHeaders = {
//       'Accept': 'application/json',
//       'authorization': "Bearer $token"
//     };
//     var response = await http.get(Uri.parse(url), headers: requestHeaders);
//     if (response.statusCode == 200) {
//       var jsonString = json.decode(response.body);
//       UserModel userData = UserModel.fromJson(jsonString);
//       return userData;
//     } else {
//       print("Get Profile No Data");
//     }
//   }
//
//   Future logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('token');
//     return prefs.remove('token');
//   }
//
//   UserModel usermode;
//   PickedFile _imageFile;
//   final ImagePicker _picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff610047),
//         leadingWidth: 0,
//         centerTitle: true,
//         leading: Container(),
//         title: Text(
//           "Profile",
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         elevation: 0,
//       ),
//       backgroundColor: Colors.white,
//       body: Stack(children: [
//         Container(
//           height: MediaQuery.of(context).size.height,
//           child: FutureBuilder(
//               future: getProfile(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 return Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Container(
//                       height: double.infinity,
//                       child: Stack(
//                         children: [
//                           Image.asset("assets/icons/profileRountd.png",
//                               color: Color(0xff610047),
//                               height: 200,
//                               width: double.infinity,
//                               fit: BoxFit.cover),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       top: 100,
//                       child: Container(
//                         height: 200,
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 2, color: Colors.black.withOpacity(0.3)),
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(30),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.3),
//                                 spreadRadius: 0.3,
//                                 blurRadius: 4,
//                                 offset:
//                                 Offset(0, 9), // changes position of shadow
//                               ),
//                             ]),
//                         child: Stack(
//                           // ignore: deprecated_member_use
//                           overflow:
//                           // ignore: deprecated_member_use
//                           Overflow.visible,
//                           alignment: Alignment.topCenter,
//                           children: [
//                             Positioned(
//                                 top: -55,
//                                 child: Container(
//                                   height: 100,
//                                   width: 100,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Colors.purple, width: 3.0),
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(100))),
//                                   child: CircleAvatar(
//                                     radius: 50,
//                                     backgroundImage: NetworkImage(
//                                       "https://wwwimage-us.pplusstatic.com/thumbnails/photos/w425-q80/cast/cast_manwithaplan_mattleblanc.jpg",
//                                     ),
//                                   ),
//                                 )),
//                             Column(
//                               children: [
//                                 SizedBox(height: 60),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   child: Column(
//                                     children: [
//                                       Text(
//                                         snapshot.data.data.name,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                             color: Colors.black),
//                                       ),
//                                       SizedBox(height: 5),
//                                       Text(
//                                         snapshot.data.data.username,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.grey,
//                                             height: 1,
//                                             fontSize: 16),
//                                       ),
//                                       SizedBox(height: 20),
//                                       Container(
//                                         height: 1,
//                                         width:
//                                         MediaQuery.of(context).size.width,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "FOLLOWING",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.bold,
//                                                       fontSize: 17,
//                                                       color: Colors.grey),
//                                                 ),
//                                                 SizedBox(height: 5),
//                                                 Text(
//                                                   "100k",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.bold,
//                                                       fontSize: 17),
//                                                 )
//                                               ],
//                                             ),
//                                             Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                               children: [
//                                                 Text(
//                                                   "DIAMONDS",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.bold,
//                                                       fontSize: 17,
//                                                       color: Colors.grey),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 5,
//                                                 ),
//                                                 Text(
//                                                   "16",
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                       FontWeight.bold,
//                                                       fontSize: 17),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Positioned(
//                               right: 10,
//                               child: IconButton(
//                                   icon: Icon(
//                                     Icons.edit,
//                                     color: Colors.black,
//                                     size: 26,
//                                   ),
//                                   onPressed: () {
//                                     updateProfile(
//                                       snapshot.data.data.name,
//                                     );
//                                   }),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//
//
//                     Positioned(
//                       bottom: 20,
//                       child: Container(
//                         height: 230,
//                         width: MediaQuery.of(context).size.width * 0.9,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 2, color: Colors.black.withOpacity(0.3)),
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(30),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 5,
//                                 blurRadius: 4,
//                                 offset:
//                                 Offset(0, 3), // changes position of shadow
//                               ),
//                             ]),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               onTap: () {
//                                 _showMyDialog();
//                               },
//                               leading: Icon(Icons.settings,
//                                   size: 25, color: Colors.pink),
//                               title: Text(
//                                 "settings",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(Icons.keyboard_arrow_right,
//                                   size: 35, color: Colors.grey),
//                             ),
//                             ListTile(
//                               onTap: () => _showMyDialog(),
//                               leading: Icon(
//                                 Icons.share_sharp,
//                                 size: 25,
//                                 color: Colors.pink,
//                               ),
//                               title: Text(
//                                 "Shear This App",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 35,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () => _showMyDialog(),
//                               leading: Icon(
//                                 Icons.help_center_outlined,
//                                 size: 25,
//                                 color: Colors.pink,
//                               ),
//                               title: Text(
//                                 "Help & Feedback",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 35,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             ListTile(
//                               onTap: () {
//                                 logout();
//                                 Navigator.of(context).pushAndRemoveUntil(
//                                     MaterialPageRoute(
//                                         builder: (BuildContext context) =>
//                                             LoginScreen()),
//                                         (Route<dynamic> route) => false);
//                               },
//                               leading: Icon(
//                                 Icons.login_outlined,
//                                 size: 25,
//                                 color: Colors.pink,
//                               ),
//                               title: Text(
//                                 "Log Out",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.grey[600]),
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 35,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }),
//         ),
//       ]),
//     );
//   }
//
//   Future<void> _showMyDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('AlertDialog Title'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('This is a demo alert dialog.'),
//                 Text('Would you like to approve of this message?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Approve'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<bool> updateProfile(String name) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token');
//     Map<String, String> requestHeaders = {
//       'Accept': 'application/json',
//       'authorization': "Bearer $token"
//     };
//     final TextEditingController nameContrllers =
//     TextEditingController(text: name);
//     final _key = GlobalKey<FormState>();
//
//     void updateData(String titile) {
//       var upUrl = "https://test.iqbal.live/api/user/profile";
//       http.put(
//         Uri.parse(upUrl),
//         body: {
//           "name": titile,
//         },
//         headers: requestHeaders,
//       );
//     }
//
//     return Alert(
//         context: context,
//         title: "Update Profile",
//         content: Form(
//           key: _key,
//           child: Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 10,
//               ),
//               Stack(
//                 children: [
//                   Container(
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Colors.purple.withOpacity(0.5), width: 3.0),
//                         borderRadius: BorderRadius.all(Radius.circular(100))),
//                     child: CircleAvatar(
//                       radius: 50,
//                       backgroundImage: _imageFile == null
//                           ? NetworkImage(
//                         "https://wwwimage-us.pplusstatic.com/thumbnails/photos/w425-q80/cast/cast_manwithaplan_mattleblanc.jpg",
//                       )
//                           : FileImage(File(_imageFile.path)),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 1,
//                     right: 1,
//                     child: GestureDetector(
//                       onTap: () {
//                         showModalBottomSheet(
//                             context: (context),
//                             builder: (builder) => bottomSheetProfileEdit());
//                       },
//                       child: Container(
//                         height: 30,
//                         width: 30,
//                         decoration: BoxDecoration(
//                             color: Colors.purple, shape: BoxShape.circle),
//                         child: Icon(Icons.edit_outlined,
//                             size: 18, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               TextField(
//                 controller: nameContrllers,
//                 decoration: InputDecoration(labelText: "Name"),
//               ),
//             ],
//           ),
//         ),
//         buttons: [
//           DialogButton(
//             onPressed: () {
//               updateData(nameContrllers.text);
//               Navigator.pop(context);
//             },
//             color: Colors.purple,
//             child: Text(
//               "SUBMIT",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//           )
//         ]).show();
//   }
//
//   void takePhoto(ImageSource source) async {
//     final pickedFile = await _picker.getImage(source: source);
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   }
//
//   Widget bottomSheetProfileEdit() {
//     return Container(
//       height: 100,
//       width: MediaQuery.of(context).size.width,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Column(
//         children: [
//           Text(
//             "Choose profle photo",
//             style: TextStyle(
//               fontSize: 20,
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               FlatButton.icon(
//                 icon: Icon(Icons.camera),
//                 label: Text("Camera"),
//                 onPressed: () {
//                   takePhoto(ImageSource.camera);
//                 },
//               ),
//               FlatButton.icon(
//                 icon: Icon(Icons.image),
//                 label: Text("Gellery"),
//                 onPressed: () {
//                   takePhoto(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
