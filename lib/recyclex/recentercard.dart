import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashtrace/data/models/recyclexmodel.dart';

class RecycleCentreCard extends StatelessWidget {
  RecycleCentreCard({super.key});

  final List<CentreInfo> centres = [
    CentreInfo(
      name: 'Muthu Recycle',
      type: 'All',
      imagePath: 'assets/RecycleCenter.jpeg',
      contact: '9901552081',
    ),
    CentreInfo(
      name: 'Santhosh Recycle',
      type: 'Electrical',
      imagePath: 'assets/RecycleCenter.jpeg',
      contact: '9449320808',
    ),
    CentreInfo(
      name: 'Kawasaki Recycle',
      type: 'Steel',
      imagePath: 'assets/RecycleCenter.jpeg',
      contact: '7483070772',
    ),
  ];

  void _openCentreDetails(BuildContext context, CentreInfo centre) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              Image.asset(centre.imagePath),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Name : ${centre.name}',
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Type : ${centre.type}',
                style: GoogleFonts.lato(fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                label: Text(
                  centre.contact,
                  style: const TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.navigation),
                label: const Text('Navigate'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: centres.length,
        itemBuilder: (BuildContext context, int index) {
          final centre = centres[index];
          return GestureDetector(
            onTap: () {
              _openCentreDetails(context, centre);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 7),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      centre.imagePath,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 270, // Adjust the image height as needed
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Name : ${centre.name}',
                        style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        'Type : ${centre.type}',
                        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.navigation),
                        label: const Text('Navigate'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
