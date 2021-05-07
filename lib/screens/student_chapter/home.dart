import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'create_event.dart';
import '../welcome.dart';

class StudentChapterHome extends StatefulWidget {
  final Map userData;
  StudentChapterHome({this.userData});
  @override
  _StudentChapterHomeState createState() => _StudentChapterHomeState();
}

class _StudentChapterHomeState extends State<StudentChapterHome> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Welcome(),
                  ),
                  (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Student Chapter Home",
          style: GoogleFonts.lato(
            fontSize: 20.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainThemeColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEvent(),
            ),
          );
        },
      ),
    );
  }
}
