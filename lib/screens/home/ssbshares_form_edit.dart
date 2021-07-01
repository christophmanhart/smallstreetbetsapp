import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/services/databaseSsbShares.dart';
import 'package:smallstreetbetsapp/shared/constants.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class SsbSharesFormEdit extends StatefulWidget {
  final SsbShares ssbshares;
  Empfehlung currentEmpfehlung;

  SsbSharesFormEdit({this.ssbshares, this.currentEmpfehlung});

  @override
  _SsbSharesFormEditState createState() => _SsbSharesFormEditState();
}

class _SsbSharesFormEditState extends State<SsbSharesFormEdit> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentWkn;

  //Empfehlung _currentEmpfehlung = ssbshares.empfehlung;
  String _currentZielkurs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
        color: Colors.grey[850],
        child: _dataLoadedForm(context),
      ),
    );
  }

  Widget _dataLoadedForm(BuildContext context) {
    //_currentName = widget.ssbshares.name;
    //_currentWkn = widget.ssbshares.wkn;
    //_currentZielkurs = widget.ssbshares.zielkurs;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 80.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () => Navigator.pop(context),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "Empfehlung aktualisieren",
                style: TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            initialValue: widget.ssbshares.name,
            decoration: textInputDecoration.copyWith(hintText: "Name"),
            validator: (value) => value.isEmpty ? "Aktien-Name fehlt" : null,
            onChanged: (value) => setState(() => _currentName = value),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            initialValue: widget.ssbshares.wkn,
            decoration: textInputDecoration.copyWith(hintText: "WKN"),
            validator: (value) => value.isEmpty ? "Aktien-WKN fehlt" : null,
            onChanged: (value) => setState(() => _currentWkn = value),
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            initialValue: widget.ssbshares.zielkurs,
            decoration: textInputDecoration.copyWith(hintText: "Zielkurs"),
            validator: (value) =>
                value.isEmpty ? "Aktien-Zielkurs fehlt" : null,
            onChanged: (value) => setState(() => _currentZielkurs = value),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.currentEmpfehlung == Empfehlung.dontbuy
                        ? Colors.white
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "💩",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    widget.currentEmpfehlung = Empfehlung.dontbuy;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.currentEmpfehlung == Empfehlung.hold
                        ? Colors.white
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "👐🏻",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    widget.currentEmpfehlung = Empfehlung.hold;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.currentEmpfehlung == Empfehlung.buy
                        ? Colors.white
                        : null,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "👍🏻",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    widget.currentEmpfehlung = Empfehlung.buy;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
              color: Colors.green[800],
              child: Text(
                "Aktualisieren",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    if(_currentName == null) {
                      _currentName = widget.ssbshares.name;
                    }
                    if(_currentWkn == null) {
                      _currentWkn = widget.ssbshares.wkn;
                    }
                    if(_currentZielkurs == null) {
                      _currentZielkurs= widget.ssbshares.zielkurs;
                    }
                    DatabaseSsbSharesService().updateSharesData(
                      _currentName,
                      _currentWkn,
                      _currentZielkurs,
                      widget.currentEmpfehlung,
                      widget.ssbshares.documentId,
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
