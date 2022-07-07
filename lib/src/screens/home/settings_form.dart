// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bigquery_models_firestore/src/models/user_model.dart';
import 'package:test_bigquery_models_firestore/src/services/database.dart';
import 'package:test_bigquery_models_firestore/src/theme/loading.dart';
import 'package:test_bigquery_models_firestore/src/theme/myTheme.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  String? currentName;
  String? currentSugars;
  int? currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObject?>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Update your brew settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData?.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => currentName = val),
                  ),
                  SizedBox(height: 20),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: currentSugars ?? userData?.sugars,
                    items: sugars.map(
                      (sugar) {
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      },
                    ).toList(),
                    onChanged: (val) =>
                        setState(() => currentSugars = val.toString()),
                  ),
                  // slider
                  Slider(
                    value: (currentStrength ?? userData?.strength)!.toDouble(),
                    activeColor:
                        Colors.brown[currentStrength ?? userData!.strength],
                    inactiveColor: Colors.brown.shade200,
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) => setState(() {
                      currentStrength = val.round();
                    }),
                  ),
                  SizedBox(height: 20),
                  // button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
                    onPressed: () async {
                      // update
                      print(currentName);
                      print(currentSugars);
                      print(currentStrength);
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user?.uid).updateUserData(
                          currentSugars ?? userData?.sugars ?? 'Error',
                          currentName ?? userData?.name ?? 'Error',
                          currentStrength ?? userData?.strength ?? 0,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
