import 'package:flutter/material.dart';
import 'package:trashtrace/login.dart';
//import 'package:trashtag/server.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nc = TextEditingController();
  final uc = TextEditingController();
  final pc = TextEditingController();

  @override
  void dispose() {
    nc.dispose();
    uc.dispose();
    pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 241, 244),
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: 300,
          height: 310,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nc,
                decoration: const InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: uc,
                decoration: const InputDecoration(hintText: "Username"),
              ),
              TextField(
                controller: pc,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Register"),
                onPressed: () {
                  print(uc.text);
                  print(pc.text);
                  print(nc.text);
                  // register(nc.text, uc.text, pc.text).then((x) {
                  //   if (x) {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => LoginScreen()));
                  //   } else
                  //     print("Not Done");
                  //   //Go to Login
                  // });
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
