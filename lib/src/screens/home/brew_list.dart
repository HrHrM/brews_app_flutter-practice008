import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_bigquery_models_firestore/src/models/brew_model.dart';
import 'package:test_bigquery_models_firestore/src/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context) ?? [];

    // if (brews != null) {
    //   for (var brew in brews) {
    //     print(brew.name);
    //     print(brew.sugars);
    //     print(brew.strength);
    //   }
    // }

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) {
          return BrewTile(
            brew: brews[index],
          );
        });
  }
}
