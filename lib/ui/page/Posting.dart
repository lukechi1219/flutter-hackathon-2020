import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../../key.dart';

final kHintTextStyle = TextStyle(
  color: Colors.black54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white70,
  // color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class Posting extends StatefulWidget {
  @override
  _PostingState createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  PickResult pickResult;
  DateTime dateTime;
  TextEditingController location = TextEditingController();
  TextEditingController deadline = TextEditingController();
  TextEditingController description = TextEditingController();

  void posting() {
    print(dateTime.toString());
    print(pickResult);
    print(description.text);
    //TODO : Upload Data
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 35),
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Posting",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              buildLocationinput(pickResult),
              SizedBox(
                height: 15,
              ),
              buildDeadlineinput(context),
              SizedBox(
                height: 15,
              ),
              buildDescriptinput(),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
                child: RaisedButton(
                  elevation: 5,
                  onPressed: posting,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.white,
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Color.fromRGBO(54, 55, 149, 1),
                      letterSpacing: 1.5,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }



  Column buildDescriptinput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Description",
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            controller: description,
            style: TextStyle(color: Colors.black54),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
                hintText: "Description",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Column buildDeadlineinput(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "DeadLine",
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            controller: deadline,
            onTap: () {
              DatePicker.showDateTimePicker(
                context,
                showTitleActions: true,
                onChanged: (time) => setState(() {
                  deadline.text = DateFormat.yMd().add_jm().format(time);
                }),
                onConfirm: (time) {
                  dateTime = time;
                  setState(() {
                    deadline.text = DateFormat.yMd().add_jm().format(time);
                  });
                },
              );
            },
            readOnly: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black54),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.timer,
                  color: Colors.white,
                ),
                hintText: "Deadline",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  static final kInitialPosition = LatLng(25.0326811, 121.5646961);

  void _waitlocationchoose(
      BuildContext context, TextEditingController controller) async {
    pickResult = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: googleapikey, // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            print(result.formattedAddress);
            Navigator.pop(context, result);
          },
          initialPosition: kInitialPosition,
          useCurrentLocation: true,
        ),
      ),
    );
    updatelocation(controller);
  }

  void updatelocation(TextEditingController controller) {
    setState(() {
      location.text = pickResult == null ? "" : pickResult.formattedAddress;
    });
  }

  Column buildLocationinput(PickResult pickResult) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Location",
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            onTap: () {
              _waitlocationchoose(context, location);
            },
            readOnly: true,
            controller: location,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black54),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  //TODO: Get Location Method
                ),
                hintText: "Location",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }
}
