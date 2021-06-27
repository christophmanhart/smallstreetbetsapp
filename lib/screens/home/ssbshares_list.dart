import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/screens/home/ssbshares_tile.dart';

class SsbSharesList extends StatefulWidget {
  @override
  _SsbSharesListState createState() => _SsbSharesListState();
}

class _SsbSharesListState extends State<SsbSharesList> {
  @override
  Widget build(BuildContext context) {
    final ssbshares = Provider.of<List<SsbShares>>(context) ?? [];
    //ssbshares.sort()

    return ListView.builder(
      itemCount: ssbshares.length,
      itemBuilder: (context, index) {
        return SsbSharesTile(
          ssbshares: ssbshares[index],
          index: index,
        );
      },
    );
  }
}
