import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  final Map userData;
  Landing({this.userData});
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.userData['name']),
      ),
    );
  }
}
