import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutterhood/ui/page/Posting.dart';
import 'ui/page/Notification.dart';
import 'ui/page/Profile.dart';
import 'ui/page/Home.dart';

void main() {
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
        primarySwatch: Colors.blue,
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
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 260),
    // );

    // final curvedAnimation =
    //     CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    // _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

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
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 150),
          child: Container(
            width: 100,
            child: FittedBox(
              child: FloatingActionButton(
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
              heroTag: "add",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Posting(),
                    ));
              },
              child: Icon(Icons.add),
            ),
          ),
        )
      ],
    );
  }
}

class BubbleFloat extends StatelessWidget {
  const BubbleFloat({
    Key key,
    @required AnimationController animationController,
    @required Animation<double> animation,
  })  : _animationController = animationController,
        _animation = animation,
        super(key: key);

  final AnimationController _animationController;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      // Menu items
      items: <Bubble>[
        // Floating action menu item
        Bubble(
          title: "Story",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.book,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ),
        // Floating action menu item
        Bubble(
          title: "Picture",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.photo,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ),
        //Floating action menu item
        Bubble(
          title: "Action",
          iconColor: Colors.white,
          bubbleColor: Colors.blue,
          icon: Icons.work,
          titleStyle: TextStyle(fontSize: 16, color: Colors.white),
          onPress: () {
            _animationController.reverse();
          },
        ),
      ],

      // animation controller
      animation: _animation,

      // On pressed change animation state
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),

      // Floating Action button Icon color
      iconColor: Colors.white,

      // Flaoting Action button Icon
      iconData: Icons.share,
      backGroundColor: Colors.blue,
    );
  }
}
