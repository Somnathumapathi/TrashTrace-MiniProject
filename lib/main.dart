import 'package:flutter/material.dart';
import 'package:trashtrace/trashtrace.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.green,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
      ),
    ),
    home: const TrashTrace(),
  ));
}
