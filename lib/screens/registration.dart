import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/utils/apiCaller.dart';
import 'package:metx/utils/form_validators.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isObscure = true;
  final _formKey = GlobalKey<FormState>();
  int initIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Image.asset('assets/logo.png'),
                SizedBox(
                  height: 20.0,
                ),
                ToggleSwitch(
                  inactiveBgColor: Colors.grey[900],
                  inactiveFgColor: Colors.white54,
                  activeBgColor: Colors.blueGrey[500],
                  activeFgColor: Colors.white,
                  minWidth: 150,
                  initialLabelIndex: initIndex,
                  labels: ['Student', 'Student Chapter'],
                  onToggle: (index) {
                    print('switched to: $index');
                    setState(() {
                      initIndex = index;
                    });
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
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
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: emailValidator,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your VIT Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: passwordValidator,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter A Strong Password',
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  validator: (val) {
                    if (val.isEmpty) return "*Required";
                    if (val != _passwordController.text)
                      return "Passwords don't match";
                    return null;
                  },
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        color: Colors.white,
                        icon: isObscure
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        }),
                    hintText: 'Verify Your Password',
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
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
                      if (_formKey.currentState.validate()) {
                        var userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "phone": "",
                          "password": _passwordController.text,
                          "user_type":
                              initIndex == 0 ? "student" : "student_chapter",
                          "img_url": "",
                        };
                        ApiCaller a = ApiCaller();
                        var res = await a.register(userData);
                        var body = json.decode(res);
                        if (body['status'] == 201) {
                          print("Registration successful");
                          return;  
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Registration Error"),
                        ));
                      }
                    },
                    child: Text(
                      "REGISTER",
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
