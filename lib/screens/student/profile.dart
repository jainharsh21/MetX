import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  final Map userData;
  StudentProfile({this.userData});
  @override
  StudentProfileState createState() => StudentProfileState();
}

class StudentProfileState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
    );
  }
}
