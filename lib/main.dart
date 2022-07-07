import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bigquery_models_firestore/src/models/user_model.dart';
import 'package:test_bigquery_models_firestore/src/screens/authentication/authentication.dart';
import 'package:test_bigquery_models_firestore/src/screens/home/home..dart';
import 'package:test_bigquery_models_firestore/src/screens/wrapper.dart';
import 'package:test_bigquery_models_firestore/src/services/auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Firebase inicializado');
  runApp(const MyApp());
  print('App inicializado');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserObject?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'coffee app',
        initialRoute: 'wrapper',
        routes: {
          'wrapper': (BuildContext context) => Wrapper(),
          'home': (BuildContext context) => HomePage(),
          'auth': (BuildContext context) => Authenticate(),
        },
      ),
    );
  }
}
