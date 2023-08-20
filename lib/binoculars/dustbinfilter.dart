import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DustbinDistanceFilterWidget extends StatelessWidget {
  final TextEditingController radiusController;
  final Function(double?) onRadiusSelected;
  const DustbinDistanceFilterWidget({
    Key? key,
    required this.onRadiusSelected,
    required this.radiusController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.social_distance),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Distance Filter'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: radiusController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      label: Text(
                        'Distance (km)',
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final d = radiusController.value.text;
                      if (d.isEmpty) {
                        onRadiusSelected(null);
                      } else {
                        final radius = double.tryParse(d);
                        onRadiusSelected(radius);
                      }
                    },
                    child: const Text('Search'),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class DustbinTypeFilterWidget extends StatelessWidget {
  final Function(String) onFilterSelected;
  const DustbinTypeFilterWidget({Key? key, required this.onFilterSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.menu),
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Filter Dustbins'),
              content: Container(
                height: 400,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        onFilterSelected('MAMT');
                      },
                      child: const Text('MAMT'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        onFilterSelected('Non-Biodegradable');
                      },
                      child: const Text('Non-Biodegradable'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        onFilterSelected('Biodegradable');
                      },
                      child: const Text('Biodegradable'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        onFilterSelected('Hazardous');
                      },
                      child: const Text('Hazardous'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        onFilterSelected('E-Waste');
                      },
                      child: const Text('E-Waste'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        onFilterSelected('Recyclable');
                      },
                      child: const Text('Recyclable'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        onFilterSelected('ALL');
                      },
                      child: const Text('ALL'),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
