import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:metx/constants/colors.dart';
import 'package:metx/screens/student_chapter/landing.dart';
import 'package:metx/utils/apiCaller.dart';
import 'package:metx/utils/form_validators.dart';
import 'package:uuid/uuid.dart';

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

  File file;
  final _picker = ImagePicker();
  bool isUploading = false;
  String eventUrl = '';

  handleTakePhoto() async {
    // to take the photo from the camera.
    Navigator.pop(context);
    XFile file = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 900,
      maxWidth: 960,
    );
    if (file != null) {
      setState(() {
        this.file = File(file.path);
      });
    }
  }

  handleImageFromGallery() async {
    Navigator.pop(context);
    XFile file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        this.file = File(file.path);
      });
    }
  }

  selectEventPic(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            elevation: 45.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text(
              "Choose Event Picture",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                child: Text(
                  "Image With Camera",
                  style: TextStyle(),
                ),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text(
                  "Image From Gallery",
                  style: TextStyle(),
                ),
                onPressed: handleImageFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  // ignore: missing_return
  Future<String> uploadImageToFirebase(imageFile) async {
    String url = "";
    FirebaseStorage storage = FirebaseStorage.instance;
    var id = Uuid().v4();
    Reference ref = storage.ref().child("event-images/$id");
    UploadTask uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    return url;
  }

  uploadImage() async {
    setState(() {
      isUploading = true;
    });
    String imageUrl = await uploadImageToFirebase(file);
    setState(() {
      isUploading = false;
      eventUrl = imageUrl;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Image Uploaded!"),
      ),
    );
  }

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
                SizedBox(height: 10),
                Text("Upload Event Iamge"),
                SizedBox(height: 10),
                Card(
                  child: Container(
                    color: Colors.white,
                    height: 200,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          selectEventPic(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: file != null
                                ? DecorationImage(
                                    fit: BoxFit.fill, image: FileImage(file))
                                : null,
                            color: Colors.blueGrey,
                          ),
                          child: Center(
                            child: file == null
                                ? Icon(
                                    Icons.camera_alt,
                                    size: 58.0,
                                    color: Colors.white,
                                  )
                                : SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.upload),
                    style: ElevatedButton.styleFrom(
                      primary: mainThemeColor,
                    ),
                    onPressed: file != null
                        ? () async {
                            await uploadImage();
                          }
                        : null,
                    label: Text(
                      "Upload Image",
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                        "event_img_url": eventUrl,
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
