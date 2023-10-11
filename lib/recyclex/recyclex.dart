import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:trashtrace/backend/backend.dart';
import 'package:trashtrace/data/models/recyclexmodel.dart';
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
  void initState() {
    super.initState();
    initialize();
  }

  List<ReCyclXJob> jobs = [];

  initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedin_username') ?? '';
    final uid = await TrashTraceBackend().getUserID(username: username);
    if (uid.result == null) {
      Toast.show('Could not find UserID');
      return;
    }
    final res = await TrashTraceBackend().getAllMyJobs(uid.result!);
    if (res.result == null) {
      Toast.show('Could not get Jobs');
      return;
    }
    jobs = [...res.result!];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 241, 244),
      body: SingleChildScrollView(
        child: Column(
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
            // ElevatedButton(onPressed: () {}, child: Text('My Jobs')),
            if (jobs.isNotEmpty) ...[
              Text(
                'My Jobs',
                style: GoogleFonts.aBeeZee(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ...jobs
                  .map(
                    (j) => j.status == 'completed'
                        ? SizedBox()
                        : ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            title: Text('${j.partnerName} (${j.partnerType})'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(j.name),
                                Text(j.date),
                              ],
                            ),
                            tileColor: Colors.greenAccent.withAlpha(50),
                            trailing: Chip(
                              label: Text(j.status),
                              backgroundColor: j.status == 'pending'
                                  ? Colors.amber
                                  : Colors.white,
                            ),
                          ),
                  )
                  .toList(),
              const SizedBox(
                height: 20,
              ),
            ],
            Text(
              'ReCyclX Partners',
              style: GoogleFonts.aBeeZee(
                  fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            RecycleCentreCard(
              onJobBookedCallback: () async {
                await initialize();
                setState(() {});
              },
            ),
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
      ),
    );
  }
}
