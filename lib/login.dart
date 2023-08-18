import 'package:flutter/material.dart';
import 'package:trashtrace/register.dart';
//import 'package:trashtag/server.dart';

//import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final uc = TextEditingController();
  final pc = TextEditingController();
  @override
  void dispose() {
    uc.dispose();
    pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 241, 244),
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          width: 300,
          height: 260,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                child: const Text("Login"),
                onPressed: () {
                  print(uc.text);
                  print(pc.text);
                  // login(uc.text, pc.text).then((x) {
                  //   if (x) {
                  //     Navigator.of(context).push(
                  //         MaterialPageRoute(builder: (context) => Home()));
                  //   } else
                  //     print("Incorrect");
                  // });
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Don\'t have an account? Register',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w300,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
