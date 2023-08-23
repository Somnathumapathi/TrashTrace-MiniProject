import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trashtrace/recyclex/recentercard.dart';

class RecycleX extends StatefulWidget {
  const RecycleX({super.key});

  @override
  State<RecycleX> createState() => _RecycleXState();
}

class _RecycleXState extends State<RecycleX> {
  final carouselimages = [
    Image.asset(
      'assets/RecycleX1.png',
    ),
    Image.asset(
      'assets/RecycleX2.png',
    ),
    Image.asset(
      'assets/RecycleX3.png',
    ),
    Image.asset(
      'assets/RecycleX4.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 241, 244),
      body: Column(
        children: [
          CarouselSlider(
            items: carouselimages,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'ReCyclX Partners',
            style:
                GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          RecycleCentreCard(),
          const SizedBox(
            height: 20,
          ),
          // Text(
          //   'Types',
          //   style:
          //       GoogleFonts.aBeeZee(fontSize: 15, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
