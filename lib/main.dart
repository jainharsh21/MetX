import 'dart:convert';

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:metx/screens/student/landing.dart';
import 'package:metx/screens/student_chapter/landing.dart';
import 'package:metx/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/error.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Error();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MetX',
            theme: ThemeData(
              brightness: Brightness.light,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              /* dark theme settings */
            ),
            themeMode: ThemeMode.dark,
            home: FutureBuilder<SharedPreferences>(
              future: SharedPreferences.getInstance(),
              builder:
                  // ignore: missing_return
                  (BuildContext context,
                      AsyncSnapshot<SharedPreferences> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  // if it is in a waiting state show a loader.
                  case ConnectionState.waiting:
                    return CircularProgressIndicator();
                  default:
                    // if there is no error in the snapshot then get user type and redirect them to their login page.
                    // if there is no user type -> first time -> redirect to welcome chat bot page
                    if (!snapshot.hasError) {
                      var data = snapshot.data.getString('userData');
                      if (data != null) {
                        var userData = json.decode(data);
                        return userData["data"]['user_type'] == "student"
                            ? StudentLanding(
                                userData: userData["data"],
                              )
                            : StudentChapterLanding(
                                userData: userData["data"],
                              );
                      }
                      return Welcome();
                    }
                }
              },
            ),
            // home: MyApp(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
