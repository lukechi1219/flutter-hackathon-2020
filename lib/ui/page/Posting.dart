import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:intl/intl.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../../key.dart';
import '../../data/entities/post_itrm.dart';

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
  color: Colors.white,
  border: Border.all(color: Colors.black, width: 0.5),
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
  TextEditingController phone = TextEditingController();

  void posting() {
    var postitem = PostItem(
        createTime: DateTime.now(),
        location: LatLng(
          pickResult.geometry.location.lat,
          pickResult.geometry.location.lng,
        ),
        text: description.text,
        postEndTime: dateTime,
        creator: "Flutter");

    //TODO : Upload Data
    Navigator.pop(context, postitem);
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
                "Help Request",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
              buildDeadlineinput(context),
              SizedBox(
                height: 15,
              ),
              buildPhoneInput(),
              SizedBox(
                height: 15,
              ),
              buildLocationinput(pickResult),
              SizedBox(
                height: 15,
              ),
              buildDescriptinput(),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: posting,
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Theme.of(context).buttonColor,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.0),
                      child: RaisedButton(
                        elevation: 5,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Theme.of(context).buttonColor,
                        child: Text(
                          "Back",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            keyboardType: TextInputType.phone,
            controller: phone,
            style: TextStyle(color: Colors.black54),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
                hintText: "Contact Number",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }

  Column buildDescriptinput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.topLeft,
          decoration: kBoxDecorationStyle,
          height: 200,
          child: TextField(
            maxLines: null,
            controller: description,
            style: TextStyle(color: Colors.black54),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.star,
                  color: Colors.black54,
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
                  color: Colors.black54,
                ),
                hintText: "Duration",
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
                  color: Colors.black54,
                ),
                hintText: "Location",
                hintStyle: kHintTextStyle),
          ),
        )
      ],
    );
  }
}
