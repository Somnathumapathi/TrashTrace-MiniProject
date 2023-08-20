import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:trashtrace/backend/backend.dart';
import 'package:trashtrace/binoculars/dustbindetails.dart';
import 'package:trashtrace/binoculars/dustbinfilter.dart';
import 'package:trashtrace/data/models/dustbin.dart';
import 'package:location/location.dart' as loc;

import '../utils.dart';

class Binoculars extends StatefulWidget {
  const Binoculars({super.key});

  @override
  State<Binoculars> createState() => _BinocularsState();
}

class _BinocularsState extends State<Binoculars> {
  final loc.Location location = loc.Location();
  late StreamSubscription<loc.LocationData> locationSubscription;
  TextEditingController radiusController = TextEditingController();

  late GoogleMapController mapController;
  // late Position userPosition;
  LatLng? currentUserPosition;
  BitmapDescriptor? cuMarkerIcon;

  bool loadingBins = true;
  List<Dustbin> dustbins = [];

  double? radius;

  loadAssetMarkers() async {
    cuMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/person.png',
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((_) {
      loadAssetMarkers();
      getDusbins();
      print('Initial GetDustbins Call Made');
    });
  }

  @override
  void dispose() {
    locationSubscription.cancel();
    super.dispose();
  }

  getDusbins() async {
    setState(() {
      loadingBins = true;
    });
    dustbins = await TrashTraceBackend().getAllBins();
    setState(() {
      loadingBins = false;
      dustbins = [...dustbins];
    });
  }

  getDustbinsAtDistance() async {
    setState(() {
      loadingBins = true;
    });
    if (radius == null) {
      await getDusbins();
    } else {
      if (currentUserPosition == null) return;
      dustbins = await TrashTraceBackend().getProximalBins(
        lat: currentUserPosition!.latitude,
        lng: currentUserPosition!.longitude,
        radius: radius!,
      );
    }
    print("LATEST DUSTBINS => $dustbins");
    setState(() {
      loadingBins = false;
      dustbins = [...dustbins];
    });
  }

  Future<void> _getCurrentLocation() async {
    final sub = await Utils.initalizeLocationServices(
      context: context,
      locationInstance: location,
      onFirstLocationReceived: (lc) {
        if (lc.latitude == null || lc.longitude == null) return;
        currentUserPosition = LatLng(lc.latitude!, lc.longitude!);
        print('CurrentUserPosition Updated!');
      },
    );
    if (sub == null) return;
    locationSubscription = sub.listen((loc) {
      print('CurrentUserLocUpdated => $loc');
      currentUserPosition = LatLng(loc.latitude!, loc.longitude!);
      setState(() {});
    });
    setState(() {});
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

  Set<Marker> getMarkers() {
    List<Marker> markers = [];
    //CurrentUser
    markers.add(
      Marker(
        markerId: const MarkerId('cu'),
        position: currentUserPosition!,
        icon: cuMarkerIcon ??
            BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
      ),
    );
    //Dustbins
    for (final dustbin in dustbins) {
      markers.add(
        Marker(
          markerId: MarkerId('${dustbin.latitude}_${dustbin.longitude}'),
          position: LatLng(dustbin.latitude, dustbin.longitude),
          icon: getColor(dustbin),
          onTap: () {
            if (currentUserPosition == null) return;
            print(currentUserPosition);
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return DustbinDetails(
                  dustbin: dustbin,
                  userPosition: currentUserPosition!,
                );
              },
            );
          },
        ),
      );
    }
    return markers.toSet();
  }

  getDustbinsBasedOnFilter(String filter) async {
    await getDusbins();
    if (filter != 'ALL') {
      dustbins = dustbins.where((e) => e.type == filter).toList();
    }
    setState(() {
      dustbins = [...dustbins];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loadingBins || currentUserPosition == null)
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            )
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentUserPosition!,
                    zoom: 14,
                  ),
                  markers: getMarkers(),
                ),
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        DustbinDistanceFilterWidget(
                          radiusController: radiusController,
                          onRadiusSelected: (r) async {
                            radius = r;
                            await getDustbinsAtDistance();
                            Navigator.pop(context);
                            print('Loaded Dustbin based on Distance!');
                          },
                        ),
                        const SizedBox(width: 5),
                        DustbinTypeFilterWidget(
                          onFilterSelected: (filter) async {
                            await getDustbinsBasedOnFilter(filter);
                            Navigator.pop(context);
                            print('Loaded Dustbin based on Filter!');
                          },
                        ),
                        const SizedBox(width: 5),
                        FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () async {
                            await mapController.animateCamera(
                              CameraUpdate.newLatLng(currentUserPosition!),
                            );
                            await Future.delayed(const Duration(seconds: 1),
                                () {
                              mapController
                                  .animateCamera(CameraUpdate.zoomBy(5));
                            });
                          },
                          child: const Icon(Icons.home),
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
