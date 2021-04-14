import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metx/utils/apiCaller.dart';
import 'package:metx/utils/form_validators.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  height: 60.0,
                ),
                Image.asset('assets/logo.png'),
                SizedBox(
                  height: 60.0,
                ),
                TextFormField(
                  controller: _emailController,
                  validator: emailValidator,
                  decoration: InputDecoration(
                    hintText: 'Enter Your VIT Email',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: passwordValidator,
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
                  height: 60.0,
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
                        Map userData = {
                          "email": _emailController.text,
                          "password": _passwordController.text,
                        };
                        ApiCaller a = new ApiCaller();
                        await a.login(userData);
                      }
                    },
                    child: Text(
                      "LOGIN",
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
