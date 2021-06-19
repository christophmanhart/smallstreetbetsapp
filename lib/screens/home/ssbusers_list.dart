import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbuser.dart';
import 'package:smallstreetbetsapp/screens/home/ssbuser_tile.dart';

class SsbusersList extends StatefulWidget {
  @override
  _SsbusersListState createState() => _SsbusersListState();
}

class _SsbusersListState extends State<SsbusersList> {
  @override
  Widget build(BuildContext context) {
    final ssbusers = Provider.of<List<Ssbuser>>(context) ?? [];

    return ListView.builder(
      itemCount: ssbusers.length,
      itemBuilder: (context, index) {
        return SsbuserTile(ssbuser: ssbusers[index]);
      },
    );
  }
}
