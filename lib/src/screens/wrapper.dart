import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bigquery_models_firestore/src/models/user_model.dart';
import 'package:test_bigquery_models_firestore/src/screens/authentication/authentication.dart';
import 'package:test_bigquery_models_firestore/src/screens/home/home..dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObject?>(context);
    print('Verificando si hay usuario conectado');
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
