// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test_bigquery_models_firestore/src/models/brew_model.dart';

class BrewTile extends StatefulWidget {
  BrewTile({Key? key, required this.brew}) : super(key: key);

  final Brew? brew;

  @override
  State<BrewTile> createState() => _BrewTileState();
}

class _BrewTileState extends State<BrewTile> {
  @override
  Widget build(BuildContext context) {
    print('//////// datos que llegan para las tiles ////////');
    print(widget.brew?.name);
    print(widget.brew?.sugars);
    print(widget.brew?.strength);
    print('//////////////////////////////////');
    int circleAvatarColor;
    String listTileName;
    String listTileSugars;
    if (widget.brew?.strength == null ||
        widget.brew?.sugars == null ||
        widget.brew?.name == null) {
      circleAvatarColor = 0;
      listTileName = '';
      listTileSugars = '';
    } else {
      circleAvatarColor = widget.brew!.strength;
      listTileName = widget.brew!.name;
      listTileSugars = widget.brew!.sugars;
    }
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.only(top: 8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[circleAvatarColor],
          ),
          title: Text(listTileName),
          subtitle: Text('Takes $listTileSugars sugars(s)'),
        ),
      ),
    );
  }
}
