import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smallstreetbetsapp/services/auth.dart';
import 'package:smallstreetbetsapp/shared/constants.dart';
import 'package:smallstreetbetsapp/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field states for mail and password
  String name = "";
  String email = "";
  String password = "";
  String passwordUeberpruefung = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[850],
            appBar: AppBar(
              backgroundColor: Colors.grey[850],
              elevation: 0.0,
              title: Text("Bei HWB registrieren"),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text("Einloggen",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Name"),
                      validator: (value) => value.isEmpty ? "Name fehlt" : null,
                      onChanged: (value) {
                        setState(() => name = value.trim());
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "E-Mail"),
                      validator: (value) =>
                          value.isEmpty ? "E-Mail Adresse fehlt" : null,
                      onChanged: (value) {
                        setState(() => email = value.trim());
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Passwort"),
                      validator: (value) => value.length < 6
                          ? "Das Passwort muss mindestens 6 Zeichen lang sein"
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => password = value.trim());
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                          hintText: "Passwort erneut eingeben"),
                      validator: (value) => value.length < 6
                          ? "Das Passwort muss mindestens 6 Zeichen lang sein"
                          : null,
                      obscureText: true,
                      onChanged: (value) {
                        setState(() => passwordUeberpruefung = value.trim());
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.green[800],
                      child: Text(
                        "Registrieren",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (password == passwordUeberpruefung) {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    email, password, name);
                            if (result == null) {
                              setState(() {
                                error =
                                    "Bitte eine valide E-Mail Adresse eingeben";
                                loading = false;
                              });
                            }
                          }
                        } else {
                          setState(() {
                            error = "Passwörter müssen gleich sein";
                            loading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
