import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class SsbShares {
  final String name;
  final String wkn;
  final String zielkurs;
  final Empfehlung empfehlung;
  final String id;

  SsbShares({this.name, this.wkn, this.zielkurs, this.empfehlung, this.id});
}

class SsbSharesData {
  final String uid;
  final String name;
  final String wkn;
  final String zielkurs;
  final Empfehlung empfehlung;
  final String id;

  SsbSharesData({this.uid, this.name, this.wkn, this.zielkurs, this.empfehlung, this.id});
}
