import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
class TabChoices {
  final String title;
  final IconData icon;

  const TabChoices({this.title, this.icon});
}

const List<TabChoices> tabChoices = <TabChoices>[
  TabChoices(title: "Hot Stocks", icon: Icons.local_fire_department),
  TabChoices(title: "Neuste", icon: Icons.fiber_new),
  TabChoices(title: "Profil", icon: Icons.person),
];

class TabChoicesPage extends StatelessWidget {
  const TabChoicesPage({Key key, this.tabChoices}) : super(key: key);
  final TabChoices tabChoices;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;

    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              tabChoices.icon,
              size: 150.0,
              color: textStyle.color,
            ),
            Text(
              tabChoices.title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
 */

//TODO cmn das kann man dann einbauen bei home.dart
/*
class TabbedAppBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: tabChoices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Tabbed AppBar"),
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
              return Padding(
                padding: EdgeInsets.all(20.0),
                //TODO cmn hier müssten dann die einzelnen Seiten aufgerufen werden
                child: TabChoicesPage(
                  tabChoices: tabChoices,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

 */
