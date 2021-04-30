import 'package:flutter/material.dart';

    class ProfileUpdate extends StatefulWidget {
      @override
      _ProfileUpdateState createState() => _ProfileUpdateState();
    }

    class _ProfileUpdateState extends State<ProfileUpdate> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
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
          ),
        );
      }
    }
