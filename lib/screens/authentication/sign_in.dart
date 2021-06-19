import 'package:flutter/material.dart';
import 'package:smallstreetbetsapp/services/auth.dart';
import 'package:smallstreetbetsapp/shared/constants.dart';
import 'package:smallstreetbetsapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = new AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field states for mail and password
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.green[400],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              elevation: 0.0,
              title: Text("Bei SSB einloggen"),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Registrieren",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                        setState(() => password = value);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.green[800],
                      child: Text(
                        "Einloggen",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = "Anmeldedaten falsch";
                              loading = false;
                            });
                          }
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
