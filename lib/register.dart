import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtrace/login.dart';
import 'package:trashtrace/utils.dart';

import 'backend/backend.dart';
import 'home.dart';
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
  bool showPassword = false;

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
                obscureText: !showPassword,
                controller: pc,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(
                        () {
                          showPassword = !showPassword;
                        },
                      );
                    },
                    icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text("Register"),
                onPressed: () async {
                  print(uc.text);
                  print(pc.text);
                  print(nc.text);
                  final res = await TrashTraceBackend().register(
                    username: uc.value.text,
                    name: nc.value.text,
                    password: pc.value.text,
                  );
                  if (res == true) {
                    print('Register Successful!');
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('loggedin_username', uc.text);
                    print('LoginData Saved Successfully!');
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                        return Home();
                      }),
                      (route) => false,
                    );
                  } else {
                    Utils.showUserDialog(
                      context: context,
                      title: 'Register Failed',
                      content: 'Could be a Server Issue',
                    );
                  }
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
