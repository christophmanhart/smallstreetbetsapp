import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  //hier muss dann auf die Daten des aktuell eingeloggten Users zugegriffen werden

  //Profilbild, Name

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        margin: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: CircleAvatar(
                  radius: 80.0,
                  //TODO cmn hier muss dann aus der DB ein Bild geladen werden
                  //backgroundColor: Colors.brown,
                  backgroundImage:
                      AssetImage('assets/images/profile.png'),
                  //child: Image.asset("assets/images/profile.png",
                  //  fit: BoxFit.fitHeight,
                  //width: height3 * 0.045,
                  //height: height3 * 0.045,
                  //image: AssetImage('assets/images/star_personal.png'),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Toph",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
