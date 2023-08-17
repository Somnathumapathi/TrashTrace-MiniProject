import 'package:flutter/material.dart';
import 'package:trashtrace/trashtrace.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Color.fromARGB(255, 5, 130, 61)),
    home: TrashTrace(),
  ));
}
