import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TrashTrace extends StatefulWidget {
  const TrashTrace({super.key});

  @override
  State<TrashTrace> createState() => _TrashTraceState();
}

class _TrashTraceState extends State<TrashTrace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrashTrace'),
        backgroundColor: const Color.fromARGB(255, 5, 130, 61),
      ),
      body: const Center(child: Text('Home')),
      bottomNavigationBar: const GNav(
        backgroundColor: Color.fromARGB(255, 5, 130, 61),
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(153, 5, 185, 86),
        gap: 7,
        padding: EdgeInsets.all(16),
        tabMargin: EdgeInsets.all(5),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.backpack,
            text: 'TrashTag',
          ),
          GButton(icon: Icons.backpack, text: 'Binoculars'),
          GButton(icon: Icons.backpack, text: 'RecycleX'),
        ],
      ),
    );
  }
}
