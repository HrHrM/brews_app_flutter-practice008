// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_bigquery_models_firestore/src/services/auth.dart';
import 'package:test_bigquery_models_firestore/src/theme/loading.dart';
import 'package:test_bigquery_models_firestore/src/theme/myTheme.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
              title: Text('Sign in to the brew crew'),
              actions: [
                ElevatedButton.icon(
                  onPressed: () {
                    // toggle view
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign up'),
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
                            setState(() {
                              email = val;
                            });
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          decoration: textInputDecoration.copyWith(
                              hintText: 'password'),
                          obscureText: true,
                          validator: (val) => val!.length < 6
                              ? 'Enter a password longer than 6 characters'
                              : null,
                          onChanged: (val) {
                            // password controller
                            setState(() {
                              password = val;
                            });
                          }),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          // Sign in
                          print('sign in pressed');
                          print(email);
                          print(password);
                          if (_formKey.currentState!.validate()) {
                            // sign up function
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              // error
                              setState(() {
                                error = 'Please supply valid information';
                              });
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Text(
                          'Sign in',
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
