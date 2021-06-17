import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class SsbShares {
  final String name;
  final String wkn;
  final double zielkurs;
  final Empfehlung empfehlung;

  SsbShares({this.name, this.wkn, this.zielkurs, this.empfehlung});
}

class SsbSharesData {
  final String name;
  final String wkn;
  final double zielkurs;
  final Empfehlung empfehlung;

  SsbSharesData({this.name, this.wkn, this.zielkurs, this.empfehlung});
}
