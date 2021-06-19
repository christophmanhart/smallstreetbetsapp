import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/models/the_user.dart';
import 'package:smallstreetbetsapp/services/database.dart';
import 'package:smallstreetbetsapp/services/databaseSsbShares.dart';
import 'package:smallstreetbetsapp/shared/constants.dart';
import 'package:smallstreetbetsapp/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentWkn;
  String _currentEmpfehlung = "hold";
  String _currentZielkurs;
  String _currentUid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SsbSharesData>(
        //stream: DatabaseService(uid: user.uid).userData,
        stream: DatabaseSsbSharesService().ssbSharesData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //UserData userData = snapshot.data;
            SsbSharesData sharesData = snapshot.data;

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
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Name"),
                    validator: (value) =>
                        value.isEmpty ? "Aktien-Name fehlt" : null,
                    onChanged: (value) => setState(() => _currentName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "WKN"),
                    validator: (value) =>
                        value.isEmpty ? "Aktien-WKN fehlt" : null,
                    onChanged: (value) => setState(() => _currentWkn = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: "Zielkurs"),
                    validator: (value) =>
                        value.isEmpty ? "Aktien-Zielkurs fehlt" : null,
                    onChanged: (value) =>
                        setState(() => _currentZielkurs = value),
                  ),
                  SizedBox(
                    height: 20.0,
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
                  /*
                  Slider(
                    value: (2.0).toDouble(),
                    //value: (_currentAlter ?? userData.alter).toDouble(),
                    activeColor: Colors
                        .brown[_currentEmpfehlung ?? sharesData.empfehlung],
                    inactiveColor: Colors
                        .brown[_currentEmpfehlung ?? sharesData.empfehlung],
                    min: 0.0,
                    max: 2.0,
                    divisions: 2,
                    onChanged: (value) => setState(
                        () => _currentEmpfehlung = value.round() as String),
                  ),

                   */
                  /*
              TextFormField(
                decoration: textInputDecoration,
                validator: (value) =>
                value.isEmpty ? "Bitte ein Alter eingeben" : null,
                onChanged: (value) => setState(() => _currentAlter = value),
              ),
               */
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
                              _currentName ?? sharesData.name,
                              _currentWkn ?? sharesData.wkn,
                              _currentZielkurs ?? sharesData.zielkurs,
                              _currentEmpfehlung ?? sharesData.empfehlung,
                            );
                            Navigator.pop(context);
                          } else {
                            print("hilfe");
                          }
                        });
                        print("hilfe2");
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
