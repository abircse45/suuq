import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:page_transition/page_transition.dart';
import 'package:suuq_somali/animation/FadeAnimation.dart';
import 'package:suuq_somali/car/CarPage.dart';
import 'package:suuq_somali/classes/language.dart';
import 'package:suuq_somali/localization/language_constants.dart';
import 'package:suuq_somali/utils/Utility.dart';
import 'package:suuq_somali/utils/app_theme.dart';

import '../home_bottom.dart';
import '../main.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/images/suuq_logo.png",
          height: 90,
          width: 170,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<Language>(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.red,
              ),
              onChanged: (Language language) {
                _changeLanguage(language);
              },
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>(
                    (e) => DropdownMenuItem<Language>(
                  value: e,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(e.name)
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 600),
                          child: HomeBottom(Utility.PROPERTY),
                        ),
                      );
                    },
                    child: FadeAnimation(
                      0.2,
                      ItemCard("assets/images/real-state.png", getTranslated(context, "property"),),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRightWithFade,
                          duration: Duration(milliseconds: 600),
                          child: HomeBottom(Utility.CAR),
                        ),
                      );
                    },
                    child: FadeAnimation(
                      0.2,
                      ItemCard("assets/images/car.png", getTranslated(context, "car"),),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6,),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      duration: Duration(milliseconds: 600),
                      child: HomeBottom(Utility.ANYTHING),
                    ),
                  );
                },
                child: FadeAnimation(
                  0.2,
                  ItemCard("assets/images/market.png", getTranslated(context, "market"),),
                ),),
          ],
        ),
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
      const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        height: 150,
        width: 500,
        child: Material(

          child: DecoratedBox(
            decoration: BoxDecoration(
              color: HexColor("#dc3545"),
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: 80,
                    width: 80,
                    color: Colors.white,
                    image: AssetImage(

                      image,

                    ),

                  ),
                  SizedBox(height: 12.0),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
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

