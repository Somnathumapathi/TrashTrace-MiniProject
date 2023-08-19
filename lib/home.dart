import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:trashtrace/binoculars/binoculars.dart';
import 'package:trashtrace/trashtag/scan.dart';
import 'package:trashtrace/trashtag/trashtaghome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  final Map<int, String> appBarTitles = {
    0: 'TrashTrace Home',
    1: 'TrashTag',
    2: 'Binoculars',
    3: 'ReCyclX Home',
  };

  String appBar = 'TrashTrace';

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
      return Binoculars();
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
        title: Text(appBar),
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
          setState(() {
            pageIndex = i;
            appBar = appBarTitles[i]!;
          });
        },
        gap: 7,
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.all(5),
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.one_x_mobiledata, text: 'TrashTag'),
          GButton(icon: Icons.pin_drop_rounded, text: 'Binoculars'),
          GButton(icon: Icons.backpack, text: 'RecycleX'),
        ],
      ),
      floatingActionButton: getFAB(),
    );
  }
}
