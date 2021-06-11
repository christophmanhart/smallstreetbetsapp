import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/the_user.dart';
import 'package:smallstreetbetsapp/services/database.dart';
import 'package:smallstreetbetsapp/shared/constants.dart';
import 'package:smallstreetbetsapp/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> names = ["", "Jonas", "Chris", "Torsten"];

  // form values
  String _currentNames;
  String _currentName2;
  int _currentAlter;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your user settings",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value.isEmpty ? "Bitte einen Namen eingeben" : null,
                    onChanged: (value) => setState(() => _currentNames = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //dropdown -> mal sehen was ich hier noch einbauen kann
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    // TODO cmn hier wieder ?? ""
                    value: _currentNames ?? userData.name,
                    items: names.map((name) {
                      return DropdownMenuItem(
                        value: name,
                        child: Text("$name names"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _currentNames = value);
                    },
                    isDense: true,
                  ),
                  //Slider -> wie gut schätzen wir die Chancen der Aktie ein?
                  Slider(
                    value: (_currentAlter ?? userData.alter).toDouble(),
                    activeColor: Colors.brown[_currentAlter ?? userData.alter],
                    inactiveColor:
                        Colors.brown[_currentAlter ?? userData.alter],
                    min: 100.0,
                    max: 900.0,
                    divisions: 10,
                    onChanged: (value) =>
                        setState(() => _currentAlter = value.round()),
                  ),
                  /*
              TextFormField(
                decoration: textInputDecoration,
                validator: (value) =>
                value.isEmpty ? "Bitte ein Alter eingeben" : null,
                onChanged: (value) => setState(() => _currentAlter = value),
              ),
               */
                  RaisedButton(
                      color: Colors.pink[400],
                      child: Text(
                        "Aktualisieren",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentNames ?? userData.name,
                            _currentAlter ?? userData.alter,
                          );
                          Navigator.pop(context);
                        }
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
