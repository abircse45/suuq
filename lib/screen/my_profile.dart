import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suuq_somali/main.dart';
import 'package:suuq_somali/screen/update_profile_screen.dart';
import 'package:suuq_somali/utils/app_theme.dart';


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

  String token;

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
