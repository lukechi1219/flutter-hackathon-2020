// import 'package:dartz/dartz.dart'; 好像跟Materialdart衝突

import 'dart:ffi';

import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutterhood/ui/page/Posting.dart';

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
          headline1: TextStyle(fontSize:30 ,color: Color(0xff2FBCA1),fontWeight: FontWeight.w300),
          button: TextStyle(color: Colors.white,fontSize: 12)
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Main(),
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildTripleFAB(context),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentindex,
      //   onTap: onTapped,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
      //     // BottomNavigationBarItem(
      //     //     icon: Icon(Icons.notifications), title: Text("Notification")),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person), title: Text("Profile"))
      //   ],
      // ),

      body: _pages[_currentindex],
    );
  }

  Row buildTripleFAB(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          width: 75,
          child: FittedBox(
            child: FloatingActionButton(
              heroTag: "Member",
              onPressed: () {},
              child: Text(
                "Member",
                maxLines: 1,
                textScaleFactor: 0.8,
              ),
              backgroundColor: Theme.of(context).backgroundColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 150),
          child: Container(
            width: 100,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).backgroundColor,
                onPressed: () {},
                heroTag: "Compile",
                child: Text(
                  "Compile",
                  textScaleFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 75,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).backgroundColor,
              heroTag: "add",
              onPressed: () {
                helpRequest(context);
              },
              child: Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }

  void helpRequest(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Posting(),
        ));

    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "Send Success",
                      style: Theme.of(context).textTheme.headline1,
                      textAlign: TextAlign.center,
                    )),
                Container(
                  margin: EdgeInsets.all(30),
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          child: ListTile(
                        leading: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                        ),
                        title: Text(result.creator),
                        subtitle: Text("LA"),
                      )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Testing Description Testing Description Testing Description Testing Description Testing Description",
                          maxLines: null,
                          style: TextStyle(),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: 60,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.tealAccent[700],
                    child: Text("Done",style: TextStyle(fontSize: 15,color: Colors.white),),
                    onPressed: () {},
                    shape: StadiumBorder(),
                  ),
                )
              ],
            ));
  }
}
