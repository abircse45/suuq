import 'package:flutter/material.dart';

  class SearchPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Search",style: TextStyle(fontSize: 18),),
            ],
          ),
        ),
      );
    }
  }
