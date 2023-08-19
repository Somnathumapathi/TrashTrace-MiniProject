import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashtrace/data/models/dustbin.dart';
import 'package:url_launcher/url_launcher.dart';

class DustbinDetails extends StatelessWidget {
  const DustbinDetails(
      {super.key, required this.dustbin, required this.userPosition});
  final Dustbin dustbin;
  final Position userPosition;

  @override
  Widget build(BuildContext context) {
    double distance = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      dustbin.latitude,
      dustbin.longitude,
    );
    return Column(
      children: [
        Text('Type : ${dustbin.type}'),
        Text('Distance : $distance km'),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
            onPressed: () async {
              String googleMapsUrl =
                  'https://www.google.com/maps/dir/?api=1&destination=${dustbin.latitude},${dustbin.longitude}';
              if (await canLaunchUrl(googleMapsUrl as Uri)) {
                await launchUrl(googleMapsUrl as Uri);
              } else {
                throw 'Could not launch Google Maps';
              }
            },
            icon: const Icon(Icons.navigation),
            label: const Text('Navigate'))
      ],
    );
  }
}
