import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Home extends StatelessWidget {
    Location myUserLocation;

  GoogleMapController mapController;
//TODO:Define Center With GPS
  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
Marker marker =Marker()
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GoogleMap(
        markers: ,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center)),
          
    );
  }
}
