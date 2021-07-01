import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class SsbSharesFormDetail extends StatelessWidget {
  //hier muss dann auf die Daten des aktuell eingeloggten Users zugegriffen werden
  final SsbShares ssbshares;

  //Profilbild, Name
  SsbSharesFormDetail({
    this.ssbshares,
  });

  Widget _showIcon(BuildContext context) {
    switch (ssbshares.empfehlung) {
      case Empfehlung.buy:
        return Text(
          "👍🏻",
          style: TextStyle(fontSize: 66.0),
        );
        break;
      case Empfehlung.dontbuy:
        return Text(
          "💩",
          style: TextStyle(fontSize: 66.0),
        );
        break;
      case Empfehlung.hold:
        return Text(
          "👐🏻",
          style: TextStyle(fontSize: 72.0),
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
        color: Colors.grey[850],
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: Padding(
          padding:
              EdgeInsets.only(left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20.0,
                  ),
                  GestureDetector(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                      color: Colors.white,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: _showIconBackgroundColor(context),
                  child: _showIcon(context),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                ssbshares.name,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 6.0,
              ),
              Text(
                "${ssbshares.wkn}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Zielkurs: ${ssbshares.zielkurs}€",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Dabei seit: ${ssbshares.timestamp}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "Hinzugefügt durch: ${ssbshares.timestamp}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "👍🏻",
                        style: TextStyle(fontSize: 28.0),
                      ),
                      //TODO cmn hier die Zahl aus der Datenbank lesen
                      Text(
                        "3",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "👐🏻",
                        style: TextStyle(fontSize: 34.0),
                      ),
                      //TODO cmn hier die Zahl aus der Datenbank lesen
                      Text(
                        "1",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "💩",
                        style: TextStyle(fontSize: 28.0),
                      ),
                      //TODO cmn hier die Zahl aus der Datenbank lesen
                      Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        shadowColor: Colors.black,
        elevation: 8.0,
      ),
    );
  }
}
