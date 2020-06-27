import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

  final Set<Marker> _markers = {};
  bool _switch = true;
  Widget splitter() {
    return _switch == true
        ? GoogleMap(
            markers: _markers,
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
    _addTestMarker();

    return Stack(children: <Widget>[
      Container(child: splitter()),
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
