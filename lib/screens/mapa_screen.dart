import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_app/models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final exampleTarget = LatLng(41.390205, 2.154007);
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: scan.getLatLng(),
          zoom: 17,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: <Marker>{
          Marker(
            markerId: MarkerId('geo-location'),
            position: scan.getLatLng(),
          ),
        },
      ),
    );
  }
}
