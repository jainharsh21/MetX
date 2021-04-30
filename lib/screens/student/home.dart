import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/constants/colors.dart';

class StudentHome extends StatefulWidget {
  final Map userData;
  StudentHome({this.userData});
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: utilityColor,
        centerTitle: true,
        title: Text(
          "MetX",
          style: GoogleFonts.stylish(),
        ),
      ),
    );
  }
}
