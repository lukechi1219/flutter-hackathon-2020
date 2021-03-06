import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhood/core/usecases/usecase.dart';
import 'package:flutterhood/domain/usecases/get_near_by_post_items.dart';
import 'package:flutterhood/ui/page/Posting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../data/entities/post_itrm.dart';
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
  LatLng _center = LatLng(25.0326811, 121.5646961);

  // Taipei 101
  LatLng _defaultPosition = LatLng(25.0326811, 121.5646961);

  // Google Office NYC Chelsea
//  final LatLng _center = const LatLng(40.7420835, -74.0061156);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Set<Marker>> getPostItems() async {
    //
    GetNearByPostItems getNearByPostItems = getIt.get<GetNearByPostItems>();

    final failureOrPostItems = await getNearByPostItems(NoParams());

    await failureOrPostItems.fold(
      (failure) => print(failure),
      (items) {
        //
        int oldSize = _markers.length;
        _markers.clear();
        print('------');
        for (var postItem in items) {
          var latLng = postItem.location;
          print(
              '${postItem.text}: ${postItem.creator}, time: ${postItem.createTime}, location: (${latLng.latitude}, ${latLng.longitude})');
          //
          _addTestMarker(postItem);
        }
        print('------');

        if (oldSize != _markers.length) {
          setState(() {
            print('set state');
          });
        }
      },
    );
    return _markers;
  }

  /*
   */
  final Set<Marker> _markers = {};

  // map is true
  bool _mapOrListSwitch = true;

  Widget splitter(data) {
    // return ;
    return null;
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
              child: Icon(Icons.list),
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
                  onPressed: () {
                    helpRequest(context);
                  },
                  heroTag: "Compile",
                  child: Icon(Icons.add)),
            ),
          ),
        ),
        Container(
          width: 75,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).backgroundColor,
              heroTag: "add",
              onPressed: () {},
              child: Icon(Icons.person),
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
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          title: Text(result.creator),
                          subtitle: Text(result.location.toString()),
                        )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "${result.text}",
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

  Future<LatLng> getNowLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      _center = const LatLng(25.0326811, 121.5646961);
      if (!_serviceEnabled) {
        _center = const LatLng(25.0326811, 121.5646961);
        return _center;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      _center = const LatLng(25.0326811, 121.5646961);
      if (_permissionGranted != PermissionStatus.granted) {
        _center = const LatLng(25.0326811, 121.5646961);
        return _center;
      }
    }

    LocationData locationData = await location.getLocation();
    _center = LatLng(locationData.latitude, locationData.longitude);
//    updatePinOnMap();
    return _center;
  }

  /**
   *
   */
  void updatePinOnMap() async {
    CameraPosition cPosition = CameraPosition(
      zoom: 16,
      target: _center,
    );

    mapController.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    setState(() {
      print('set state');
    });
  }

  /**
   *
   */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNowLocation();

//    Timer.periodic(Duration(seconds: 10), (timer) {
//      getPostItems();
//    });
  }

  @override
  Widget build(BuildContext context) {
    //

    return FutureProvider<LatLng>(
      create: (context) => getNowLocation(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: buildTripleFAB(context),
        body: Stack(children: <Widget>[
          Consumer<LatLng>(
            builder: (context, latlng, child) => Container(
                child: FutureBuilder(
                    future: getPostItems(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData) {
                        print(snapshot.data);
                        return _mapOrListSwitch
                            ? GoogleMap(
                                markers: snapshot.data,
                                onMapCreated: _onMapCreated,
                                initialCameraPosition: () {
                                  if (latlng == null) {
                                    latlng = _defaultPosition;
                                  }
                                  return CameraPosition(
                                    target: latlng,
                                    zoom: 16,
                                  );
                                }())
                            : ListView();
                      }
                      if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Text("Error");
                    })),
          ),
          Positioned(
              right: 10,
              top: 10,
              child: Switch(
                onChanged: (value) {
                  setState(() {
                    _mapOrListSwitch = value;
                  });
                },
                value: _mapOrListSwitch,
              ))
        ]),
      ),
    );
  }

  /*
   * test
   */

  void _addTestMarker(PostItem postItem) {
    //
    var dialog = (PostItem _postItem) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.NO_HEADER,
        headerAnimationLoop: false,
        btnOk: MaterialButton(
          color: Colors.tealAccent[700],
          child: Text('I want to help.'),
          onPressed: () {
            // nothing
          },
          shape: StadiumBorder(),
        ),
        body: Column(
          children: <Widget>[
            //title
            Text(
              _postItem.creator,
              textScaleFactor: 1.5,
            ),
            Text(
              _postItem.address,
              textScaleFactor: 1.0,
            ),
            Text(
              _postItem.phone,
              textScaleFactor: 1.0,
            ),
            //subtitle
            Text(
              _postItem.postEndTime.toString(),
              textScaleFactor: 1.0,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            //describe
            Text(
              _postItem.text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        btnCancelOnPress: () {
          //pop out
        },
        btnOkOnPress: () {
          setState(() {});
          //accpet
        },
      );
    }(postItem);
    //
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId('testMarker' + DateTime.now().millisecond.toString()),
      position: postItem.location,
      infoWindow: InfoWindow(
        onTap: () {},
        title: postItem.creator,
//        snippet: postItem.text,
      ),
      onTap: () {
        dialog.show();
      },
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
}
