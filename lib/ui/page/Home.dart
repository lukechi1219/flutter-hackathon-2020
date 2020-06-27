import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhood/ui/page/Posting.dart';
import '../../data/entities/post_itrm.dart';
import 'package:flutterhood/core/usecases/usecase.dart';
import 'package:flutterhood/domain/usecases/get_near_by_post_items.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../injection_container.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Location myUserLocation;

  GoogleMapController mapController;

//TODO:Define Center With GPS
//  final LatLng _center = const LatLng(45.521563, -122.677433);
  // Taipei 101
  final LatLng _center = const LatLng(25.0326811, 121.5646961);

  // Google Office NYC Chelsea
//  final LatLng _center = const LatLng(40.7420835, -74.0061156);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Set<Marker>> getPostItems() async {
    //
    GetNearByPostItems getNearByPostItems = getIt.get<GetNearByPostItems>();

    final failureOrPostItems = await getNearByPostItems(NoParams());

    failureOrPostItems.fold(
      (failure) => print(failure),
      (items) {
        print('------');
        for (var postItem in items) {
          var latLng = postItem.location;
          print(
              '${postItem.text}: ${postItem.creator}, time: ${postItem.createTime}, location: (${latLng.latitude}, ${latLng.longitude})');
          _addTestMarker(postItem);
        }
        print('------');
      },
    );
    return _markers;
  }

  final Set<Marker> _markers = {};
  bool _switch = true;
  Widget splitter(data) {
    return _switch == true
        ? GoogleMap(
            markers: data,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15,
            ))
        : ListView();
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
    if (result != null) {
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
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: StadiumBorder(),
                    ),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    //

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

      body: Stack(children: <Widget>[
        Container(
            child: FutureBuilder(
          future: getPostItems(),
          builder: (context, snapshot) => splitter(snapshot.data),
        )),
        Positioned(
            right: 10,
            top: 10,
            child: Switch(
              onChanged: (value) {
                setState(() {
                  _switch = value;
                });
              },
              value: _switch,
            ))
      ]),
    );
  }

  /*
   * test
   */

  void _addTestMarker(PostItem postItem) {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId('testMarker' + DateTime.now().millisecond.toString()),
      position: postItem.location,
      infoWindow: InfoWindow(
        onTap: () {},
        title: postItem.creator,
        snippet: postItem.text,
      ),
      onTap: () {
        //TODO : 重做UI
        showCupertinoModalPopup(
            context: context,
            builder: (cxt) => CupertinoActionSheet(
                  title: Text(
                    postItem.creator,
                    textScaleFactor: 1.5,
                  ),
                  message: Text(
                    postItem.text,
                  ),
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Accept"),
                  ),
                ));
      },
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
}
