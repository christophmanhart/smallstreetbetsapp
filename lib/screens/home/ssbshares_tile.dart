import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_form_detail.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_form_edit.dart';
import 'package:smallstreetbetsapp/services/databaseSsbShares.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';
import 'package:toast/toast.dart';

class SsbSharesTile extends StatefulWidget {
  final SsbShares ssbshares;
  final int index;

  const SsbSharesTile({Key key, this.ssbshares, this.index}) : super(key: key);

  @override
  _SsbSharesTileState createState() => _SsbSharesTileState();
}

class _SsbSharesTileState extends State<SsbSharesTile> {
  //SsbShares ssbshares;
  //int index;

  //SsbSharesTile({this.ssbshares, this.index});

  Widget _showIcon(BuildContext context) {
    switch (widget.ssbshares.empfehlung) {
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
    switch (widget.ssbshares.empfehlung) {
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
    return Slidable(
      //key: ValueKey(widget.index),
      key: UniqueKey(),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: IconSlideAction(
              caption: 'Löschen',
              color: Colors.red,
              icon: Icons.delete,
              closeOnTap: true,
              onTap: () {
                // ignore: unnecessary_statements
                Toast.show('Deleted ${widget.index}', context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                DatabaseSsbSharesService()
                    .deleteSharesData(widget.ssbshares.documentId);
              },
            ),
            shadowColor: Colors.black,
            elevation: 8.0,
          ),
        ),
      ],
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
            child: IconSlideAction(
              caption: 'Bearbeiten',
              color: Colors.orange,
              icon: Icons.edit,
              closeOnTap: true,
              onTap: () {
                // ignore: unnecessary_statements
                Toast.show('Bearbeitet: ${widget.index}', context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SsbSharesFormEdit(
                            ssbshares: widget.ssbshares,
                            currentEmpfehlung: widget.ssbshares.empfehlung,
                          )));
                });
              },
            ),
            shadowColor: Colors.black,
            elevation: 8.0,
          ),
        ),
      ],
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
      ),
      //TODO cmn Padding ist der title dann von:
      /*
      Card(
  child: Padding(
   padding: EdgeInsets.only(
      top: 36.0, left: 6.0, right: 6.0, bottom: 6.0),
      child: ExpansionTile(
      title: Text('Birth of Universe'),
        children: <Widget>[
         Text('Big Bang'),
         Text('Birth of the Sun'),
         Text('Earth is Born'),
      ],
    ),
  ),
),
       */
      child: Padding(
        padding: EdgeInsets.only(top: 2.0),
        child: GestureDetector(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 0.0, top: 4.0, right: 0.0, bottom: 4.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: _showIconBackgroundColor(context),
                        child: _showIcon(context),
                      ),
                      title: Text(
                        widget.ssbshares.name,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "${widget.ssbshares.wkn}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Zielkurs: ${widget.ssbshares.zielkurs}€",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Dabei seit: ${widget.ssbshares.timestamp}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  )
                ],
              ),
            ),
            shadowColor: Colors.black,
            elevation: 8.0,
          ),
          onTap: () {
            setState(
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SsbSharesFormDetail(
                      ssbshares: widget.ssbshares,
                    ),
                  ),
                );
              },
            );
          },
          //onLongPress: //Menü aufblasen,
          //onLongPressMoveUpdate: //Hier die Movement Daten holen und die dann dem Widget übergeben,
        ),
      ),
    );
  }
}

//TODO cmn Widget welches ein float übergeben bekommt zwischen 0 und 1 und je nachdem wenn zwischen 0 und 0,33 wird erstes Emoji und so weiter, alles größer als 0,66 ist das letzte Emoji dann
