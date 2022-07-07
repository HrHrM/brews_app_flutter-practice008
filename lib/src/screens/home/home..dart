import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bigquery_models_firestore/src/models/brew_model.dart';
import 'package:test_bigquery_models_firestore/src/screens/home/brew_list.dart';
import 'package:test_bigquery_models_firestore/src/screens/home/settings_form.dart';
import 'package:test_bigquery_models_firestore/src/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:test_bigquery_models_firestore/src/services/database.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  void showSettingsPanel() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SettingsForm(),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>?>.value(
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown.shade50,
        appBar: AppBar(
          title: Text('Brew crew'),
          backgroundColor: Colors.brown.shade400,
          elevation: 0.0,
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                // sign out
                await _auth.signOut();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown.shade400,
                elevation: 0.0,
                shadowColor: Colors.transparent,
              ),
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // settings
                showSettingsPanel();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown.shade400,
                elevation: 0.0,
                shadowColor: Colors.transparent,
              ),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
