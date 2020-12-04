import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition _initialPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 30,
    );
    Set<Marker> markers = Set<Marker>();
    markers.add(
      Marker(
        markerId: MarkerId('geo-location'),
        position: scan.getLatLng(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              icon: Icon(Icons.location_disabled),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: scan.getLatLng(),
                      zoom: 17,
                      tilt: 30,
                    ),
                  ),
                );
              })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _initialPoint,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {},
      ),
    );
  }
}
