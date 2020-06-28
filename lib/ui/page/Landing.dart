import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(scrollDirection:Axis.horizontal,
            children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.asset(
                'assets/bg/bg1.png',
                fit: BoxFit.fill,
              ),
            ),
             Container(
              width: double.infinity,
              child: Image.asset(
                'assets/bg/bg2.png',
                fit: BoxFit.fill,
              ),
            ),
             Container(
              width: double.infinity,
              child: Image.asset(
                'assets/bg/bg3.png',
                fit: BoxFit.fill,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
