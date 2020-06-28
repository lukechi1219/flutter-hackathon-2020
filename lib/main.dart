// import 'package:dartz/dartz.dart'; 好像跟Materialdart衝突

import 'package:flutter/material.dart';
import 'package:flutterhood/ui/page/Landing.dart';

import 'injection_container.dart' as di;
import 'ui/page/Home.dart';
import 'ui/page/Profile.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        buttonColor: Color(0xff2FBCA1),
        primaryColor: Color(0xff2FBCA1),
        backgroundColor: Color(0xff2FBCA1),
        brightness: Brightness.light,

        textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 30,
              color: Color(0xff2FBCA1),
              fontWeight: FontWeight.w300,
            ),
            button: TextStyle(color: Colors.white, fontSize: 12)),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Landing(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentindex = 0;
  final List<Widget> _pages = [
    Home(),
    // Notify(),
    Profile()
  ];
  void onTapped(int index) {
    setState(() {
      _currentindex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Home();
  }
}
