import 'package:flutter/material.dart';
//import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtrace/home.dart';
import 'package:trashtrace/login.dart';
import 'package:trashtrace/register.dart';

class TrashTrace extends StatefulWidget {
  const TrashTrace({super.key});

  @override
  State<TrashTrace> createState() => _TrashTraceState();
}

class _TrashTraceState extends State<TrashTrace> {
  runGateway() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('loggedin_username') != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return Home();
        }),
        (route) => false,
      );
    } else {
      print('Please Login!');
    }
  }

  @override
  void initState() {
    super.initState();
    runGateway();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrashTrace'),
        backgroundColor: Colors.green,
        leading: Image.asset('assets/TrashTraceIcon1.png'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/TrashTraceBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Welcome to TrashTrace',
                style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Log in or Register to continue',
                style: GoogleFonts.lato(color: Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('  Log in  '),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.person),
                    label: const Text('Register'),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                icon: const Icon(Icons.developer_mode),
                label: const Text('Dev Home'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
