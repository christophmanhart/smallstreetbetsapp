import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class SsbSharesTile extends StatelessWidget {
  final SsbShares ssbshares;

  SsbSharesTile({this.ssbshares});

  Widget _showIcon(BuildContext context) {
    switch (ssbshares.empfehlung) {
      case Empfehlung.buy:
        return Text(
          "👍🏻",
          style: TextStyle(fontSize: 26.0),
        );
        break;
      case Empfehlung.dontbuy:
        return Text(
          "💩",
          style: TextStyle(fontSize: 26.0),
        );
        break;
      case Empfehlung.hold:
        return Text(
          "👐🏻",
          style: TextStyle(fontSize: 32.0),
        );
        break;
      default:
        return Icon(
          Icons.error,
          color: Colors.white,
        );
    }
  }

  _showIconBackgroundColor(BuildContext context) {
    switch (ssbshares.empfehlung) {
      case Empfehlung.buy:
        //return Color(0x70FF0B);
        return Colors.green;
        break;
      case Empfehlung.dontbuy:
        return Colors.red;
        break;
      case Empfehlung.hold:
        return Colors.blue;
        break;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: _showIconBackgroundColor(context),
                  //TODO cmn basierend auf dem Enum
                  child: _showIcon(context),
                ),
                title: Text(ssbshares.name),
                subtitle: Text("${ssbshares.wkn}"),
              ),
            ),
            Text("Zielkurs: ${ssbshares.zielkurs}€"),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
        shadowColor: Colors.black,
        elevation: 8.0,
      ),
    );
  }
}
