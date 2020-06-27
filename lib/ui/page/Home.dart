import 'package:flutter/material.dart';
import 'package:flutterhood/core/usecases/usecase.dart';
import 'package:flutterhood/domain/usecases/get_near_by_post_items.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../injection_container.dart';

class Home extends StatelessWidget {
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

  void getPostItems() async {
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
        }
        print('------');
      },
    );
  }

//  Marker marker = Marker();
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    //
    _addTestMarker();

    return Center(
      child: GoogleMap(
          markers: _markers,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 15,
          )),
    );
  }

  /*
   * test
   */

  //TODO:Create Ontap for InfoWindow
  void _addTestMarker() {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId('testMarker' + DateTime.now().millisecond.toString()),
      position: _center,
      infoWindow: InfoWindow(
        onTap: () {
          print("object");
        },
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
}
