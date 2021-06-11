import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smallstreetbetsapp/models/ssbuser.dart';

class SsbuserTile extends StatelessWidget {
  final Ssbuser ssbuser;

  SsbuserTile({this.ssbuser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[ssbuser.alter],
          ),
          title: Text(ssbuser.name),
          subtitle: Text("Takes ${ssbuser.name} name"),
        ),
      ),
    );
  }
}
