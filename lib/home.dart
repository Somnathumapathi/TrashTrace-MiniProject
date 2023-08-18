import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trashtrace/trashtag/trashtaghome.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrashTrace Home'),
      ),
      body: Center(
        child: Text(
          'TrashTrace Home',
          style: GoogleFonts.luckiestGuy(fontSize: 30, color: Colors.blue),
        ),
      ),
      bottomNavigationBar: GNav(
        selectedIndex: 0,
        backgroundColor: Colors.green,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: const Color.fromARGB(138, 14, 99, 17),
        gap: 7,
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.all(5),
        tabs: [
          const GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.one_x_mobiledata,
            text: 'TrashTag',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const THome()));
            },
          ),
          const GButton(icon: Icons.backpack, text: 'Binoculars'),
          const GButton(icon: Icons.backpack, text: 'RecycleX'),
        ],
      ),
    );
  }
}
