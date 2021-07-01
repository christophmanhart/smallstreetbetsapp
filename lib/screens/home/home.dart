import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/screens/home/settings_form.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_form.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_list.dart';
import 'package:smallstreetbetsapp/screens/profile/profile.dart';
import 'package:smallstreetbetsapp/services/auth.dart';
import 'package:smallstreetbetsapp/services/database.dart';
import 'package:smallstreetbetsapp/services/databaseSsbShares.dart';

class Home extends StatelessWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            color: Colors.grey[850],
            child: SsbSharesForm(),
          );
        },
      );
    }

    return StreamProvider<List<SsbShares>>.value(
      //value: DatabaseSsbSharesService().ssbShares,
      value: _returnOrder(context, "Neuste"),
      child: DefaultTabController(
        length: tabChoices.length,
        child: Scaffold(
          backgroundColor: Colors.grey[850],
          appBar: AppBar(
            // hier nochmal schauen, wieso das mit title nicht mehr funktioniert
            //title: Text(title),
            title: Text(
              "HavenWayBets",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            backgroundColor: Colors.grey[850],
            elevation: 0.0,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _showSettingsPanel(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: GestureDetector(
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    await _auth.signOut();
                  },
                ),
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: tabChoices.map<Widget>((TabChoices tabChoices) {
                return Tab(
                  text: tabChoices.title,
                  icon: Icon(tabChoices.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: tabChoices.map((TabChoices tabChoices) {
              return TabChoicesPage(
                tabChoices: tabChoices,
              );
            }).toList(),
          ),
          //SsbSharesList(),
        ),
      ),
    );
  }
}

//TODO cmn das noch schöner gestalten, wie lagere ich das am besten aus?

class TabChoices {
  final String title;
  final IconData icon;

  const TabChoices({this.title, this.icon});
}

const List<TabChoices> tabChoices = <TabChoices>[
  TabChoices(
    title: "Neuste",
    icon: Icons.fiber_new,
  ),
  TabChoices(
    title: "Hot",
    icon: Icons.local_fire_department,
  ),
  TabChoices(
    title: "Profil",
    icon: Icons.person,
  ),
];

class TabChoicesPage extends StatelessWidget {
  const TabChoicesPage({Key key, this.tabChoices}) : super(key: key);
  final TabChoices tabChoices;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;

    return Container(
      child: _showPage(context, tabChoices.title),
    );
  }
}

Widget _showPage(BuildContext context, String title) {
  if (title == 'Hot') {
    return SsbSharesList();
  } else if (title == 'Neuste') {
    return SsbSharesList();
  } else if (title == 'Profil') {
    return Profile();
  } else {
    return null;
  }
}

Stream<List<SsbShares>> _returnOrder(BuildContext context, String title) {
  if (title == 'Hot') {
    return DatabaseSsbSharesService().ssbSharesHot;
  } else if (title == 'Neuste') {
    return DatabaseSsbSharesService().ssbShares;
  } else if (title == 'Profil') {
    return DatabaseSsbSharesService().ssbShares;
  } else {
    return null;
  }
}
