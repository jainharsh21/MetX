import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/constants/colors.dart';
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

  final _formKey = GlobalKey<FormState>();

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
