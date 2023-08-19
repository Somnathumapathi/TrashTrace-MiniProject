import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtrace/backend/backend.dart';
import 'package:trashtrace/binoculars/dustbindetails.dart';
import 'package:trashtrace/data/models/dustbin.dart';
import 'package:location/location.dart' as loc;

import '../utils.dart';

const LatLng currentLocation = LatLng(12.9094890, 77.5668655);

class Binoculars extends StatefulWidget {
  const Binoculars({super.key});

  @override
  State<Binoculars> createState() => _BinocularsState();
}

class _BinocularsState extends State<Binoculars> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  TextEditingController radiusController = TextEditingController();

  late GoogleMapController mapController;
  late Position userPosition;
  List<Dustbin> dustbins = [];

  double? radius;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  getDusbins() async {
    dustbins = await TrashTraceBackend().getAllBins();
    setState(() {});
  }

  getDustbinsAtDistance() async {
    if (radius == null) {
      getDusbins();
    } else {
      dustbins = await TrashTraceBackend().getProximalBins(
        //!HARDCODED - GET ACTUAL USER LOCATION
        lat: 12.924602551376156,
        lng: 77.58813373317656,
        radius: radius!,
      );
    }
    print("LATEST DUSTBINS => $dustbins");
    setState(() {});
  }

  void _getCurrentLocation() async {
    await Utils.initalizeLocationServices(
      context: context,
      locationInstance: location,
      locationUpdater: () {},
    );
    userPosition = await Geolocator.getCurrentPosition();
    getDusbins();
  }

  BitmapDescriptor getColor(Dustbin x) {
    double color = BitmapDescriptor.hueRed;
    switch (x.type) {
      case 'MAMT':
        color = BitmapDescriptor.hueBlue;
        break;
      case 'Non-Biodegradable':
        color = BitmapDescriptor.hueRed;
        break;
      case 'Biodegradable':
        color = BitmapDescriptor.hueGreen;
        break;
      case 'Hazardous':
        color = BitmapDescriptor.hueOrange;
        break;
      case 'E-Waste':
        color = BitmapDescriptor.hueYellow;
        break;
      case 'Recyclable':
        color = BitmapDescriptor.hueCyan;
        break;
      default:
    }
    return BitmapDescriptor.defaultMarkerWithHue(color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition:
                CameraPosition(target: currentLocation, zoom: 14),
            markers: dustbins.map((dustbin) {
              return Marker(
                markerId: MarkerId('${dustbin.latitude}_${dustbin.longitude}'),
                position: LatLng(dustbin.latitude, dustbin.longitude),
                icon: getColor(dustbin),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return DustbinDetails(
                          dustbin: dustbin, userPosition: userPosition);
                    },
                  );
                },
              );
            }).toSet(),
          ),
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.social_distance),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text('Distance Filter'),
                            content: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: radiusController,
                                    decoration: InputDecoration(
                                        label: Text(
                                      'Distance (km)',
                                      style: TextStyle(color: Colors.black45),
                                    )),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final d = radiusController.value.text;
                                      if (d.isEmpty) {
                                        radius = null;
                                      } else {
                                        radius = double.tryParse(d);
                                      }
                                      setState(() {});

                                      await getDustbinsAtDistance();

                                      Navigator.pop(context);
                                    },
                                    child: Text('Search'),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(width: 5),
                  FloatingActionButton(
                    child: Icon(Icons.menu),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: Text('Filter Dustbins'),
                            content: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      dustbins = dustbins
                                          .where((e) => e.type == 'MAMT')
                                          .toList();
                                      setState(() {});
                                    },
                                    child: Text('MAMT'),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () async {
                                      dustbins = await TrashTraceBackend()
                                          .getAllBins();
                                      setState(() {});
                                    },
                                    child: Text('ALL'),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(width: 5),
                  FloatingActionButton(
                    child: Icon(Icons.home),
                    onPressed: () {
                      // showDialog(context: context, builder: builder)
                      mapController.animateCamera(
                        CameraUpdate.newLatLng(
                          LatLng(12.924602551376156, 77.58813373317656),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
