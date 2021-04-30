import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: mainThemeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.settings),
                            Icon(Icons.edit),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          width: 180.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: backgroundColor,
                              width: 6.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 90.0,
                            backgroundImage:
                                NetworkImage(widget.userData['img_url']),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          widget.userData['name'],
                          style: GoogleFonts.stylish(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          widget.userData['email'],
                          style: GoogleFonts.stylish(
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        widget.userData['phone'] != ""
                            ? Text(
                                widget.userData['phone'],
                                style: GoogleFonts.stylish(
                                  fontSize: 20.0,
                                ),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                color: mainThemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Posts",
                            style: GoogleFonts.stylish(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "10",
                            style: GoogleFonts.stylish(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Followers",
                            style: GoogleFonts.stylish(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "100",
                            style: GoogleFonts.stylish(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Following",
                            style: GoogleFonts.stylish(
                              fontSize: 20.0,
                            ),
                          ),
                          Text(
                            "50",
                            style: GoogleFonts.stylish(
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
