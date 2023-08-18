import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:trashtrace/trashtag/scan.dart';
//import 'package:trashtag/server.dart';

class THome extends StatefulWidget {
  const THome({super.key});

  @override
  State<THome> createState() => _THomeState();
}

class _THomeState extends State<THome> {
  String? productKey;
  String? garbageKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TrashTag Home"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () async {
                //Scan Product
                String pKey =
                    await BarcodeScanner.scan() as String; //barcode scnner
                setState(() {
                  productKey = pKey;
                });
                //Scan Garbage
                String gKey =
                    await BarcodeScanner.scan() as String; //barcode scnner
                setState(() {
                  garbageKey = gKey;
                });

                // add2dustbin(productKey, garbageKey).then((x) {
                //   print("You recieved $x Coins");
                //   Toast.show("You recieved $x Coins",
                //       duration: Toast.lengthLong, gravity: Toast.bottom);
                // });
              },
              child: const CircleAvatar(
                  radius: 70,
                  child: Icon(
                    Icons.delete_outline,
                    size: 50,
                  )),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            "$productKey\n$garbageKey",
            style: GoogleFonts.luckiestGuy(color: Colors.blue),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanPage()),
          );
        },
        child: const Icon(Icons.qr_code),
      ),
    );
  }
}