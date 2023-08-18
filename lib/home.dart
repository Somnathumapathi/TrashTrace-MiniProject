import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trashtrace/trashtag/scan.dart';
import 'package:trashtrace/trashtag/trashtaghome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  getContent() {
    if (pageIndex == 0) {
      return Center(
        child: Text(
          'TrashTrace Home',
          style: GoogleFonts.luckiestGuy(fontSize: 30, color: Colors.blue),
        ),
      );
    } else if (pageIndex == 1) {
      return TrashTagFragment();
    } else if (pageIndex == 2) {
      return Center(
        child: Text(
          'Binoculars Home',
          style: GoogleFonts.luckiestGuy(fontSize: 30, color: Colors.blue),
        ),
      );
    } else if (pageIndex == 3) {
      return Center(
        child: Text(
          'ReCyclX Home',
          style: GoogleFonts.luckiestGuy(fontSize: 30, color: Colors.blue),
        ),
      );
    }
    return SizedBox();
  }

  getFAB() {
    if (pageIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanPage()),
          );
        },
        child: const Icon(Icons.qr_code),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrashTrace'),
      ),
      body: getContent(),
      bottomNavigationBar: GNav(
        selectedIndex: pageIndex,
        backgroundColor: Colors.green,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: const Color.fromARGB(138, 14, 99, 17),
        onTabChange: (i) {
          pageIndex = i;
          setState(() {});
        },
        gap: 7,
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.all(5),
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.one_x_mobiledata, text: 'TrashTag'),
          GButton(icon: Icons.backpack, text: 'Binoculars'),
          GButton(icon: Icons.backpack, text: 'RecycleX'),
        ],
      ),
      floatingActionButton: getFAB(),
    );
  }
}
