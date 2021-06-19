import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/models/the_user.dart';
import 'package:smallstreetbetsapp/services/database.dart';
import 'package:smallstreetbetsapp/services/databaseSsbShares.dart';
import 'package:smallstreetbetsapp/shared/constants.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';
import 'package:smallstreetbetsapp/shared/loading.dart';

class SsbSharesForm extends StatefulWidget {
  @override
  _SsbSharesFormState createState() => _SsbSharesFormState();
}

class _SsbSharesFormState extends State<SsbSharesForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentWkn;
  Empfehlung _currentEmpfehlung;
  String _currentZielkurs;
  double _currentValueEmpfehlung = 0.0;

  @override
  Widget build(BuildContext context) {
    /*
    return StreamBuilder<SsbSharesData>(
        stream: DatabaseSsbSharesService(uid: user.uid).ssbSharesData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //UserData userData = snapshot.data;
            SsbSharesData ssbSharesData = snapshot.data;
            return _dataLoadedForm(context, ssbSharesData);

          } else {
            return Loading();
          }
        });
    */

    return _dataLoadedForm(context);
  }

  Widget _dataLoadedForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Empfehlung hinzufügen",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Name"),
            validator: (value) => value.isEmpty ? "Aktien-Name fehlt" : null,
            onChanged: (value) => setState(() => _currentName = value),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "WKN"),
            validator: (value) => value.isEmpty ? "Aktien-WKN fehlt" : null,
            onChanged: (value) => setState(() => _currentWkn = value),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            decoration: textInputDecoration.copyWith(hintText: "Zielkurs"),
            validator: (value) =>
                value.isEmpty ? "Aktien-Zielkurs fehlt" : null,
            onChanged: (value) => setState(() => _currentZielkurs = value),
          ),
          SizedBox(
            height: 15.0,
          ),
          //dropdown -> mal sehen was ich hier noch einbauen kann
          /*
                    DropdownButtonFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Empfehlung?"),
                      // TODO cmn hier wieder ?? ""
                      value: _currentNames ?? sharesData.name,
                      items: names.map((name) {
                        return DropdownMenuItem(
                          value: name,
                          child: Text("$name Empfehlung"),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _currentNames = value);
                      },
                      isDense: true,
                    ),
                     */
          //Slider -> wie gut schätzen wir die Chancen der Aktie ein?
          Slider(
            value: (_currentValueEmpfehlung),
            //value: (_currentAlter ?? userData.alter).toDouble(),
            activeColor: Colors.green[800],
            inactiveColor: Colors.green[400],
            min: 0.0,
            max: 2.0,
            divisions: 2,
            onChanged: (value) => setState(
              () {
                _currentValueEmpfehlung = value;
                if (value == 0.0) {
                  _currentEmpfehlung = Empfehlung.dontbuy;
                } else if (value == 1.0) {
                  _currentEmpfehlung = Empfehlung.hold;
                } else if (value == 2.0) {
                  _currentEmpfehlung = Empfehlung.buy;
                } else {
                  _currentEmpfehlung = Empfehlung.dontbuy;
                }
              },
            ),
          ),
          /*
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (value) =>
                  value.isEmpty ? "Bitte ein Alter eingeben" : null,
                  onChanged: (value) => setState(() => _currentAlter = value),
                ),
                 */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "  👍🏻",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "  💩",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                "👐🏻  ",
                style: TextStyle(fontSize: 26.0),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
              color: Colors.green[800],
              child: Text(
                "Hinzufügen",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    DatabaseSsbSharesService().addSharesData(
                      _currentName,
                      _currentWkn,
                      _currentZielkurs,
                      _currentEmpfehlung,
                    );
                    Navigator.pop(context);
                  } else {
                    print("Validation failed");
                  }
                });
              }),
        ],
      ),
    );
  }
}
