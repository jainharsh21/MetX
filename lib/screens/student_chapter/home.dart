import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/constants/colors.dart';
import 'package:metx/utils/apiCaller.dart';
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
  ApiCaller a = ApiCaller();
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
      body: FutureBuilder(
        future: a.getEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          var events = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                  "OUR EVENTS",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.stylish(
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 10.0),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    var event = events[index];
                    return event['student_chapter_id'] == widget.userData['id']
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              color: mainThemeColor,
                              child: Column(
                                children: [
                                  SizedBox(height: 20.0),
                                  FutureBuilder(
                                      future: a
                                          .getUser(event['student_chapter_id']),
                                      builder: (context, snapshot) {
                                        var chapter = snapshot.data;
                                        if (!snapshot.hasData)
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        return Text(
                                          "Ogranized By : ${chapter['name']}",
                                          style: GoogleFonts.lato(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }),
                                  SizedBox(height: 20.0),
                                  Image(
                                    image: NetworkImage(event['event_img_url']),
                                  ),
                                  ExpansionTile(
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    title: ListTile(
                                      title: Text(
                                        event['name'],
                                        style: GoogleFonts.stylish(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      subtitle: Text(
                                        event['summary'],
                                        style: GoogleFonts.stylish(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Text(
                                          "Event On : ${event['eventAtOg']}",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.stylish(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Text(
                                          "Event At : ${event['location']}",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.stylish(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Text(
                                          "Description : ${event['description']}",
                                          style: GoogleFonts.stylish(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Center(
                                        child: SizedBox(
                                          height: 40.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blueGrey[600],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            onPressed: () async {},
                                            child: Text(
                                              "Edit Event",
                                              style: GoogleFonts.stylish(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainThemeColor,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEvent(userData: widget.userData,),
            ),
          );
        },
      ),
    );
  }
}
