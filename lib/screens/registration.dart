import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/utils/apiCaller.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
                initialLabelIndex: 0,
                labels: ['Student', 'Student Chapter'],
                onToggle: (index) {
                  print('switched to: $index');
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              TextFormField(
                controller: _emailController,
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
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
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
                    ApiCaller a = ApiCaller();
                    await a.login();
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
    );
  }
}
