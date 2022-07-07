import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_bigquery_models_firestore/src/models/brew_model.dart';
import 'package:test_bigquery_models_firestore/src/models/user_model.dart';

class DatabaseService {
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  final String? uid;
  DatabaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    print('creating user in firestore');
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snpashot
  List<Brew> brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.get('name') ?? '',
        sugars: doc.get('sugars'),
        strength: doc.get('strength'),
      );
    }).toList();
  }

  // userData from snapshot
  UserData userDataFromsnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name'),
      sugars: snapshot.get('sugars'),
      strength: snapshot.get('strength'),
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map((brewListFromSnapshot));
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(userDataFromsnapshot);
  }
}
