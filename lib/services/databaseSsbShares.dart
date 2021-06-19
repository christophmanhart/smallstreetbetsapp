import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class DatabaseSsbSharesService {
  //SsbShares
  //collection reference
  final CollectionReference ssbSharesCollection =
      FirebaseFirestore.instance.collection('ssbshares');

  //update old
  Future updateSharesData(
      String name, String wkn, double zielkurs, Empfehlung empfehlung) async {
    return await ssbSharesCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set({
      "name": name,
      "wkn": wkn,
      "zielkurs": zielkurs,
      "empfehlung": empfehlung.toString(),
    });
  }

  //update new
  Future newUpdateSharesData(String name, String wkn, double zielkurs,
      Empfehlung empfehlung, String id) async {
    return await ssbSharesCollection.doc().set({
      "name": name,
      "wkn": wkn,
      "zielkurs": zielkurs,
      "empfehlung": empfehlung.toString(),
      // TODO cmn die geholten Einträge in Liste abspeichern
    });
  }

  // add
  Future addSharesData(
      String name, String wkn, String zielkurs, Empfehlung empfehlung) async {
    return await ssbSharesCollection.doc().set({
      "name": name,
      "wkn": wkn,
      "zielkurs": zielkurs,
      "empfehlung": empfehlung.toString().split('.').last,
      "uid": FirebaseAuth.instance.currentUser.uid,
    });
  }

  //ssbShares list from snapshot
  List<SsbShares> _ssbSharesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SsbShares(
        name: doc.data()["name"] ?? "Name",
        wkn: doc.data()["wkn"] ?? "WKN",
        zielkurs: doc.data()["zielkurs"] ?? "Zielkurs",
        empfehlung: EnumToString.fromString(
            Empfehlung.values, doc.data()["empfehlung"] ?? "buy"),
      );
    }).toList();
  }

  // ssbSharesData from snapshot
  SsbSharesData _ssbSharesDataFromSnapshot(DocumentSnapshot snapshot) {
    return SsbSharesData(
      uid: FirebaseAuth.instance.currentUser.uid,
      name: snapshot.data()["name"],
      wkn: snapshot.data()["wkn"],
      zielkurs: snapshot.data()["zielkurs"],
      empfehlung: snapshot.data()["empfehlung"],
      id: snapshot.id,
    );
  }

  // get ssbShares stream
  Stream<List<SsbShares>> get ssbShares {
    return ssbSharesCollection.snapshots().map(_ssbSharesListFromSnapshot);
  }

  // get shares doc stream
  Stream<SsbSharesData> get ssbSharesData {
    return ssbSharesCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map(_ssbSharesDataFromSnapshot);
  }
}
