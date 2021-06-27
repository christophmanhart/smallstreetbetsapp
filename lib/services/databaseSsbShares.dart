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
  Future oldUpdateSharesData(
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

  //update new - hier in doc auch die ID rein und dann easy
  Future updateSharesData(String name, String wkn, String zielkurs,
      Empfehlung empfehlung, String documentId) async {
    return await ssbSharesCollection.doc(documentId).update({
      "name": name,
      "wkn": wkn,
      "zielkurs": zielkurs,
      "empfehlung": empfehlung.toString().split('.').last,
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
      "id": FirebaseAuth.instance.currentUser.uid,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    });
  }

  // delete SharesData --> TODO cmn wie komme ich an die ID des Elements
  Future deleteSharesData(String documentId) async {
    return await ssbSharesCollection.doc(documentId).delete();
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
        documentId: doc.id,
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

  // get ssbShares stream - TODO cmn String für den Namen übergeben
  Stream<List<SsbShares>> get ssbShares {
    return ssbSharesCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(_ssbSharesListFromSnapshot);
  }

  // sortiert nach hot
  Stream<List<SsbShares>> get ssbSharesHot {
    return ssbSharesCollection
        .orderBy("empfehlung", descending: false)
        .snapshots()
        .map(_ssbSharesListFromSnapshot);
  }

  // get shares doc stream
  Stream<SsbSharesData> get ssbSharesData {
    return ssbSharesCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map(_ssbSharesDataFromSnapshot);
  }
}
