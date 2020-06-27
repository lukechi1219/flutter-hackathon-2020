import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    getPostItems();
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

  @override
  Widget build(BuildContext context) {
    //

    return Stack(children: <Widget>[
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
    ]);
  }

  /*
   * test
   */

  //TODO:Create Ontap for InfoWindow
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
