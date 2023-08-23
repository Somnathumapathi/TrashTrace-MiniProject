import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtrace/BinOcculars/binocculars.dart';
import 'package:trashtrace/backend/backend.dart';
import 'package:trashtrace/recyclex/recyclex.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trashtrace/trashtag/scan.dart';
import 'package:trashtrace/trashtag/trashtaghome.dart';
import 'package:trashtrace/trashtrace.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;
  var url = Uri.parse('https://github.com/synapsecode/TrashTrace-MiniProject');
  var murl = Uri.parse('https://www.instagram.com/somu_7704/');

  final Map<int, String> appBarTitles = {
    0: 'TrashTrace Home',
    1: 'TrashTag',
    2: 'BinOcculars',
    3: 'ReCyclX Home',
  };

  final Map<int, Widget> pageLogos = {
    0: Image.asset('assets/TrashTraceIcon1.png'),
    1: Image.asset('assets/TrashTagLogo.png'),
    2: Image.asset('assets/BinOccularsLogo.png'),
    3: Image.asset('assets/RecycleXIcon.png'),
  };

  final hcarouselImages = [
    Image.asset('assets/1.png'),
    Image.asset('assets/2.png'),
    Image.asset('assets/3.png'),
    Image.asset('assets/4.png'),
  ];

  String appBar = 'TrashTrace';
  Widget appBarLogo = Image.asset('assets/TrashTraceIcon1.png');

  getContent() {
    if (pageIndex == 0) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/TrashTraceBg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              CarouselSlider(
                items: hcarouselImages,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
              ),
              Text(
                'Welcome to TrashTrace',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.brown),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Making Waste Management Better\nFor Better Tomorrow',
                style: GoogleFonts.lato(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 177, 166, 166)),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      launchUrl(url);
                      print('Onpressed works');
                    },
                    child: const Text(
                      'About us',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      launchUrl(url);
                    },
                    label: const Text(
                      'Help',
                      style: TextStyle(color: Colors.blue),
                    ),
                    icon: const Icon(
                      Icons.help_outline,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {
                  launchUrl(murl);
                },
                icon: const Icon(
                  Icons.support_agent_outlined,
                  color: Colors.blue,
                ),
                label: const Text(
                  'Contact Us',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              TextButton.icon(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('loggedin_username');
                  print('Logged Out!');
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                      return const TrashTrace();
                    }),
                    (route) => false,
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.blue,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
              // ElevatedButton.icon(
              //   onPressed: () async {
              //     final prefs = await SharedPreferences.getInstance();
              //     await prefs.remove('loggedin_username');
              //     print('Logged Out!');
              //     Navigator.of(context).pushAndRemoveUntil(
              //       MaterialPageRoute(builder: (context) {
              //         return TrashTrace();
              //       }),
              //       (route) => false,
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //   ),
              //   icon: const Icon(Icons.person),
              //   label: const Text('Logout'),
              // ),
            ],
          ),
        ),
      );
    } else if (pageIndex == 1) {
      return const TrashTagFragment();
    } else if (pageIndex == 2) {
      return const BinOcculars();
    } else if (pageIndex == 3) {
      return const RecycleX();
    }
    return const SizedBox();
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

  TextEditingController serverLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBar),
        leading: appBarLogo,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Change Server Link'),
                        content: Container(
                          child: TextField(
                            controller: serverLinkController,
                            decoration: const InputDecoration(
                              label: Text(
                                'Server Link',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () async {
                                await setServerLink(
                                    serverLinkController.value.text);
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: const Text('Update'))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.data_array)),
        ],
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
            appBarLogo = pageLogos[i]!;
          });
        },
        gap: 7,
        padding: const EdgeInsets.all(16),
        tabMargin: const EdgeInsets.all(5),
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.qr_code_scanner, text: 'TrashTag'),
          GButton(icon: Icons.pin_drop_rounded, text: 'BinOcculars'),
          GButton(icon: Icons.recycling, text: 'RecycleX'),
        ],
      ),
      floatingActionButton: getFAB(),
    );
  }
}
