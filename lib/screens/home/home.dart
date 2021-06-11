import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbuser.dart';
import 'package:smallstreetbetsapp/screens/home/settings_form.dart';
import 'package:smallstreetbetsapp/screens/home/ssbusers_list.dart';
import 'package:smallstreetbetsapp/services/auth.dart';
import 'package:smallstreetbetsapp/services/database.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

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

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Ssbuser>>.value(
      value: DatabaseService().ssbusers,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          // hier nochmal schauen, wieso das mit title nicht mehr funktioniert
          //title: Text(title),
          title: Text("Home"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("logout"),
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text("settings"),
            )
          ],
        ),
        body: SsbusersList(),
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
