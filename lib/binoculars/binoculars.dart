import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtrace/binoculars/dustbindetails.dart';
import 'package:trashtrace/data/models/dustbin.dart';
import 'package:trashtrace/data/dustbin_data.dart';

const LatLng currentLocation = LatLng(12.9094890, 77.5668655);

class Binoculars extends StatefulWidget {
  const Binoculars({super.key});

  @override
  State<Binoculars> createState() => _BinocularsState();
}

class _BinocularsState extends State<Binoculars> {

  late GoogleMapController mapController;
  late Position userPosition;
  
@override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    userPosition = await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          
          mapController = controller;
        
        }, 
        initialCameraPosition: CameraPosition(
          target: currentLocation,
        ),
        markers: ,
      ),
    );
  }
}
