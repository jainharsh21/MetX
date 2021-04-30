import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:metx/constants/colors.dart';
import 'package:metx/screens/student/home.dart';
import 'package:metx/screens/student/profile.dart';

class StudentLanding extends StatefulWidget {
  final Map userData;
  StudentLanding({this.userData});
  @override
  _StudentLandingState createState() => _StudentLandingState();
}

class _StudentLandingState extends State<StudentLanding> {
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
            StudentHome(
              userData: widget.userData,
            ),
            StudentProfile(
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
