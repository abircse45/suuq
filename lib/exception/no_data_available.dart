
import 'package:flutter/material.dart';


class NoDatAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Image.asset("assets/images/qqa.jpg",fit: BoxFit.cover,)),

          ],
        ),
      ),

    );
  }
}