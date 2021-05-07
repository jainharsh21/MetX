import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:metx/constants/colors.dart';
import 'package:metx/screens/student_chapter/home.dart';
import 'package:metx/screens/student_chapter/profile.dart';

class StudentChapterLanding extends StatefulWidget {
  final Map userData;
  StudentChapterLanding({this.userData});
  @override
  _StudentChapterLandingState createState() => _StudentChapterLandingState();
}

class _StudentChapterLandingState extends State<StudentChapterLanding> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            StudentChapterHome(
              userData: widget.userData,
            ),
            StudentChapterProfile(
              userData: widget.userData,
            ),
          ],
          onPageChanged: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: utilityColor,
          backgroundColor: mainThemeColor,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.person),
          ],
          height: 60.0,
          onTap: (index) {
            setState(() {
              _pageController.jumpToPage(index);
            });
          },
        ),
      ),
    );
  }
}
