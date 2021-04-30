import 'package:flutter/material.dart';
import 'package:metx/constants/colors.dart';

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
      backgroundColor: backgroundColor,
    );
  }
}
