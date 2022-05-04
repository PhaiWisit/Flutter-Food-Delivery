import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.025095, 100.655748),
    zoom: 15.8746,
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _center = LatLng(14.025095, 100.655748);

  void _onMapCreated(GoogleMapController controller) {
    final marker = Marker(
      markerId: MarkerId('place_name'),
      position: LatLng(14.025095, 100.655748),
      infoWindow: InfoWindow(
        title: 'ข้าวปุ้นโภชนา',
        snippet: '29/724',
      ),
    );

    setState(() {
      markers[MarkerId('ข้าวปุ้นโภชนา')] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: EdgeInsets.all(10),
      height: 250,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: _onMapCreated,
        markers: markers.values.toSet(),
      ),
    );
  }
}
