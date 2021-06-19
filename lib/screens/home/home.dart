import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/screens/home/settings_form.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_form.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_list.dart';
import 'package:smallstreetbetsapp/services/auth.dart';
import 'package:smallstreetbetsapp/services/database.dart';
import 'package:smallstreetbetsapp/services/databaseSsbShares.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
/*
  Widget _buildListItem(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              documentSnapshot['name'],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Text(
            documentSnapshot['wkn'].toString(),
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
      onTap: () {
        // TODO cmn
        //  hier muss noch geupdatet werden oder was geschrieben werden
      },
    );
  }
  */

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            //color: Colors.pink[900],
            //TODO cmn hier noch Hintergrundfarbe einfügen
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            //child: SettingsForm(),
            child: SsbSharesForm(),
          );
        },
      );
    }

    return StreamProvider<List<SsbShares>>.value(
      value: DatabaseSsbSharesService().ssbShares,
      child: Scaffold(
        backgroundColor: Colors.green[400],
        appBar: AppBar(
          // hier nochmal schauen, wieso das mit title nicht mehr funktioniert
          //title: Text(title),
          title: Text("SmallStreetBets"),
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: Text(""),
            ),
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: Text(""),
            ),
          ],
        ),
        body: SsbSharesList(),
      ),
    );
  }
}

/*
StreamBuilder(
stream: FirebaseFirestore.instance.collection('sharenames').snapshots(),
builder: (context, snapshot) {
if (!snapshot.hasData) return const Text('Loading');
return ListView.builder(
itemCount: snapshot.data.documents.length,
itemBuilder: (context, index) =>
_buildListItem(context, snapshot.data.documents[index]),
);
},
),
*/

/*
Row(
children: [
Expanded(
child: Text(
"Name",
style: Theme.of(context).textTheme.headline5,
),
),
Text(
"WKN",
style: Theme.of(context).textTheme.headline5,
),
],
),
SizedBox(
height: 10,
),
*/
