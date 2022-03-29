import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:metx/screens/student_chapter/landing.dart';
import 'package:metx/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'student/landing.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  handleLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('userData');
    if (data != null) {
      var userData = json.decode(data);
      return userData["data"]['user_type'] == "student"
          ? Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentLanding(
                    userData: userData["data"],
                  ),
                ),
              ),
            )
          : Timer(
              Duration(seconds: 3),
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentChapterLanding(
                          userData: userData["data"],
                        )),
              ),
            );
    }
    return Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    handleLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/splash.png',
      fit: BoxFit.cover,
    );
  }
}
