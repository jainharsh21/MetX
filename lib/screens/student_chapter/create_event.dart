import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:metx/constants/colors.dart';
import 'package:metx/screens/student_chapter/landing.dart';
import 'package:metx/utils/apiCaller.dart';
import 'package:metx/utils/form_validators.dart';

class CreateEvent extends StatefulWidget {
  final Map userData;
  CreateEvent({this.userData});
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _summaryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _feesController = TextEditingController(text: "0");
  String eventDate = '';

  final _formKey = GlobalKey<FormState>();

  Future _selectBirthdate() async {
    final df = new DateFormat('dd/MM/yyyy');
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null)
      setState(() {
        _dateController.text = df.format(picked);
        eventDate = picked.toUtc().toIso8601String();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: utilityColor,
        centerTitle: true,
        title: Text(
          "Create Event",
          style: GoogleFonts.stylish(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () async {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _nameController,
                    validator: requiredValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _summaryController,
                    validator: requiredValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter Summary',
                      labelText: 'Summary',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    minLines: 4,
                    maxLines: null,
                    controller: _descriptionController,
                    validator: requiredValidator,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'Enter Description',
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _locationController,
                    validator: requiredValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter Venue',
                      labelText: 'Venue',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _feesController,
                    validator: requiredValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter Fees',
                      labelText: 'Fees',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _selectBirthdate();
                    },
                    controller: _dateController,
                    validator: requiredValidator,
                    decoration: InputDecoration(
                      hintText: 'Enter Event Date',
                      labelText: 'Event Date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 40.0,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () async {
                      Map eventData = {
                        "name": _nameController.text,
                        "event_img_url": "testurl",
                        "description": _descriptionController.text,
                        "summary": _summaryController.text,
                        "event_at": eventDate,
                        "location": _locationController.text,
                        "fees": int.parse(_feesController.text),
                        "student_chapter_id": widget.userData['id'],
                        "tags": ['tag3', 'tag4'],
                      };
                      ApiCaller a = ApiCaller();
                      await a.createEvent(eventData);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentChapterLanding(
                            userData: widget.userData,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "CREATE EVENT",
                      style: GoogleFonts.stylish(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
