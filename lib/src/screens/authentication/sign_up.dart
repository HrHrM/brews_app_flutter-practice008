// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_bigquery_models_firestore/src/services/auth.dart';
import 'package:test_bigquery_models_firestore/src/theme/loading.dart';
import 'package:test_bigquery_models_firestore/src/theme/myTheme.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown.shade100,
            appBar: AppBar(
              backgroundColor: Colors.brown.shade400,
              elevation: 0.0,
              title: Text('Sign up to the brew crew'),
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    // toggle view
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown.shade400,
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter a valid email' : null,
                        onChanged: (val) {
                          // Name controller
                          setState(
                            () {
                              email = val;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        validator: (val) => val!.length < 6
                            ? 'Enter a password longer than 6 characters'
                            : null,
                        onChanged: (val) {
                          // password controller
                          setState(
                            () {
                              password = val;
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Sign up
                          print('sign up pressed');
                          print(email);
                          print(password);
                          if (_formKey.currentState!.validate()) {
                            // sign up function
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              // error
                              setState(() {
                                error = 'Please supply valid information';
                                // loading = false;
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
