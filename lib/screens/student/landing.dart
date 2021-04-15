import 'package:flutter/material.dart';

class StudentLanding extends StatefulWidget {
  final Map userData;
  StudentLanding({this.userData});
  @override
  _StudentLandingState createState() => _StudentLandingState();
}

class _StudentLandingState extends State<StudentLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.userData['name']),
      ),
    );
  }
}
