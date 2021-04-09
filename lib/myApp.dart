import 'package:flutter/material.dart';
import 'package:metx/screens/welcome.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Welcome();
  }
}
