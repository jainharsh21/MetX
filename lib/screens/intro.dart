import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'splash.dart';

class Intro extends StatelessWidget {
  const Intro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'Welcome!',
            body:
                'Welcome to MetX - A centralised plaform for all your socio-educational needs',
            image: buildImage('assets/logo.png', size),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Browse, Choose, Attend!',
            body:
                'Now you get to browse the happenings at your institue, choose your favourite event and even attend them in a single place!',
            image: buildImage('assets/logo.png', size),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'Create, Share, Manage!',
            body:
                'Create your events, share & publicise them and even manage using a platform designed for you!',
            image: buildImage('assets/logo.png', size),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'How To Use App?',
            body: 'Choose your prupose, Register and Start connecting!',
            footer: SizedBox(
              height: 60.0,
              width: size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Get Started"),
                onPressed: () => goToHome(context),
              ),
            ),
            image: buildImage('assets/logo.png', size),
            decoration: getPageDecoration(),
          ),
        ],
        done: Text('Continue',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        onDone: () => goToHome(context),
        showSkipButton: true,
        skip: Text(
          'Skip',
          style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
        ),
        onSkip: () => goToHome(context),
        next: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.blueGrey[600],
          child: Icon(
            Icons.chevron_right,
            color: Colors.white,
            size: 40.0,
          ),
        ),
        dotsDecorator: getDotDecoration(),
        onChange: (index) => print('Page $index selected'),
        globalBackgroundColor: Colors.black,
        nextFlex: 0,

        // isProgressTap: false,
        // isProgress: false,
        // showNextButton: false,
        // freeze: true,
        // animationDuration: 1000,
      ),
    );
  }

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Splash()),
      );

  Widget buildImage(String path, var size) => ClipRRect(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40.0),
      ),
      child: Image.asset(
        path,
        fit: BoxFit.cover,
        height: size.height * 0.4,
        width: size.width * 0.8,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        // color: Color(0xFFBDBDBD),
        activeColor: Colors.blueGrey[600],
        color: Colors.grey,
        size: Size(7, 7),
        activeSize: Size(33, 7),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28,
        ),
        bodyTextStyle: TextStyle(fontSize: 18, color: Colors.blueGrey),
        titlePadding: EdgeInsets.only(bottom: 10),
        // imagePadding: EdgeInsets.all(20),
        pageColor: Colors.black,
      );
}
