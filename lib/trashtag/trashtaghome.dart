import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:trashtrace/utils.dart';
import '../backend/backend.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class TrashTagFragment extends StatefulWidget {
  const TrashTagFragment({super.key});

  @override
  State<TrashTagFragment> createState() => _TrashTagFragmentState();
}

class _TrashTagFragmentState extends State<TrashTagFragment> {
  String? productKey;
  String? garbageKey;
  int? userID;
  double? userPoints;
  String mode = 'Product';

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (mode == 'loading') ...[
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ),
        ] else ...[
          Text(
            'Scan $mode',
            style: const TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 5),
          Text("TrashTag Points: ${userPoints ?? 'loading'}"),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: onScanButtonPressed,
              child: const CircleAvatar(
                radius: 70,
                child: Icon(
                  Icons.qr_code,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Future<String?> scanQR() async {
    ToastContext().init(context);
    final s = await Utils.requestCameraPermission();
    if (!s) {
      Toast.show('Camera Permission not given');
      return null;
    }
    final res = await scanner.scan();
    return res;
  }

  onScanButtonPressed() async {
    if (mode == 'Product') {
      //Scan the product
      final pKey = await scanQR();
      if (pKey == null) return;
      print("ProductKey: $pKey");
      setState(() {
        productKey = pKey;
        mode = 'Dustbin';
      });
    } else if (mode == 'Dustbin') {
      final gKey = await scanQR();
      if (gKey == null) return;
      print("GarbageKey: $gKey");
      setState(() {
        garbageKey = gKey;
        mode = 'loading';
      });
      await add2dustbin();
      await initialize();
      setState(() {
        mode = 'Product';
      });
    }
  }

  initialize() async {
    //Set the UserID
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('loggedin_username') ?? '';
    final uid = await TrashTraceBackend().getUserID(username: username);
    if (uid.result == null) {
      Toast.show('Could not find UserID');
      return;
    }
    setState(() {
      userID = uid.result!;
    });
    //Get the Initial amount of Points
    await getUserPoints();
  }

  add2dustbin() async {
    ToastContext().init(context);
    if (userID == null) {
      Toast.show('No UserID Found');
      return;
    }
    print("ProductKey: $productKey");
    print("GarbageKey: $garbageKey");
    final res = await TrashTraceBackend().add2dustbin(
      userId: userID!,
      qrCodeValue: productKey!,
    );
    Toast.show(res.message);
  }

  getUserPoints() async {
    if (userID == null) {
      Toast.show('Could not Fetch User Points!');
      return;
    }
    final x = await TrashTraceBackend().getUserPoints(userID: userID!);
    if (x.result == null) {
      Toast.show(x.message);
      return;
    }
    setState(() {
      userPoints = x.result!;
    });
  }
}
