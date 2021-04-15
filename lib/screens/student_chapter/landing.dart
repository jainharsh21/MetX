import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentChapterLanding extends StatefulWidget {
  final Map userData;
  StudentChapterLanding({this.userData});
  @override
  _StudentChapterLandingState createState() => _StudentChapterLandingState();
}

class _StudentChapterLandingState extends State<StudentChapterLanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
          },
          child: Text(
            widget.userData.toString(),
          ),
        ),
      ),
    );
  }
}
