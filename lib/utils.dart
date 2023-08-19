import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static showUserDialog({
    BuildContext? context,
    String? title,
    String? content,
  }) {
    showDialog(
      context: context!,
      builder: (context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(content!),
        );
      },
    );
  }

  static initalizeLocationServices({
    required loc.Location locationInstance,
    required Function locationUpdater,
    required BuildContext context,
  }) {
    if (Platform.isIOS) {
      requestPermission();
      locationInstance.changeSettings(
          interval: 300, accuracy: loc.LocationAccuracy.high);
      locationInstance.enableBackgroundMode(enable: true);
      locationUpdater();
    } else {
      //Android
      requestPermission().then((status) {
        if (status) {
          locationInstance
              .changeSettings(
                  interval: 300, accuracy: loc.LocationAccuracy.high)
              .then((_) {
            locationInstance.enableBackgroundMode(enable: true);
          }).then((_) {
            locationUpdater();
          });
        } else {
          print('PERMISSION DENIED');
          Utils.showUserDialog(
            context: context,
            content: 'We need location function to run the application!',
            title: 'Permission not given',
          );
        }
      });
    }
  }

  static Future<bool> requestPermission() async {
    var status = await Permission.location.request();
    bool permStatus = false;
    if (status.isGranted) {
      print('Location Permission Granted');
      permStatus = true;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return permStatus;
  }
}
