import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutterhood/ui/page/Home.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  PageController _controller = PageController(initialPage: 1);
  double _page = 0;
  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        _page = _controller.page;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Stack(children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/bg/bg1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 180,
                        ),
                        Image.asset("assets/Villagers_logo.png")
                      ],
                    ),
                  )
                ]),
                Stack(children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/bg/bg2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Image.asset("assets/Villagers_logo.png"),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Let you",
                            style: TextStyle(
                                fontSize: 24, fontFamily: "SignPainter"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Request assistance from \nvolunteers around you.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "RiftSoft",
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ))
                ]),
                Stack(children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/bg/bg3.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Image.asset("assets/Villagers_logo.png"),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Let you",
                            style: TextStyle(
                                fontSize: 24, fontFamily: "SignPainter"),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Help someone around you.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "RiftSoft",
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ))
                ]),
              ]),
          Center(
            child: DotsIndicator(
                dotsCount: 3,
                position: _page,
                decorator: DotsDecorator(
                    activeColor: Theme.of(context).backgroundColor)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              child: Column(children: <Widget>[
                MaterialButton(
                  minWidth: 300,
                  height: 60,
                  shape: StadiumBorder(),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: Text(
                    "GET Started",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "RiftSoft",
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 300,
                  height: 60,
                  child: OutlineButton(
                    onPressed: () {},
                    borderSide:
                        BorderSide(color: Theme.of(context).buttonColor),
                    shape: StadiumBorder(),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "RiftSoft",
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
