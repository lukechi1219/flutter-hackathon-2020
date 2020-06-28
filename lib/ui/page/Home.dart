import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterhood/domain/usecases/add_post_item.dart';
import 'package:flutterhood/ui/page/Posting.dart';
import '../../data/entities/post_itrm.dart';
import 'package:flutterhood/core/usecases/usecase.dart';
import 'package:flutterhood/domain/usecases/get_near_by_post_items.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../injection_container.dart';
import 'package:provider/provider.dart';

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

    // test
//    addPostItem();
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

  /*
   */
  void addPostItem() async {
    //
    AddPostItem addPostItem = getIt.get<AddPostItem>();

    var postItem = PostItem(
      text: 'Test Add',
      creator: 'Luke',
      location: LatLng(25.0326811, 121.5646961),
      createTime: DateTime.now(),
    );

    var result = await addPostItem(Params(item: postItem));

    print(result);
  }

  /*
   */
  final Set<Marker> _markers = {};
  bool _switch = true;

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
                            decoration:
                                BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
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

  LocationData locationData;

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

    locationData = await location.getLocation();
    _center = LatLng(locationData.latitude, locationData.longitude);
    return _center;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNowLocation();
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
              builder: (context, snapshot) => _switch == true
                  ? GoogleMap(
                      markers: snapshot.data,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: () {
                        if (latlng == null) {
                          latlng = _defaultPosition;
                        }
                        return CameraPosition(
                          target: latlng,
                          zoom: 15,
                        );
                      }())
                  : ListView(),
            )),
          ),
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
      ),
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
