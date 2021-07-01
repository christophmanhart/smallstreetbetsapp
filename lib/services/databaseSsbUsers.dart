import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';
//TODO cmn hier sollen die User abgerufen werden - diese sind mit den eingeloggten Usern per ID verknüpft

class DatabaseSsbSharesService {
  //SsbShares
  //collection reference
  final CollectionReference ssbUsersCollection =
      FirebaseFirestore.instance.collection('ssbusers');

  //final f = new DateFormat('HH:mm\ndd.MM.yyyy');
  final f = new DateFormat('\ndd.MM.yyyy');

  //update old
  Future oldUpdateSharesData(
      String name, String wkn, double zielkurs, Empfehlung empfehlung) async {
    return await ssbUsersCollection
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
    return await ssbUsersCollection.doc(documentId).update({
      "name": name,
      "wkn": wkn,
      "zielkurs": zielkurs,
      "empfehlung": empfehlung.toString().split('.').last,
    });
  }

  // add
  Future addSharesData(
      String name, String wkn, String zielkurs, Empfehlung empfehlung) async {
    return await ssbUsersCollection.doc().set({
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
    return await ssbUsersCollection.doc(documentId).delete();
  }

  //ssbShares list from snapshot
  List<SsbShares> _ssbSharesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SsbShares(
        name: (doc.data() as Map)["name"] ?? "Name",
        wkn: (doc.data() as Map)["wkn"] ?? "WKN",
        zielkurs: (doc.data() as Map)["zielkurs"] ?? "Zielkurs",
        empfehlung: EnumToString.fromString(
            Empfehlung.values, (doc.data() as Map)["empfehlung"] ?? "buy"),
        documentId: doc.id,
        timestamp: f.format(DateTime.fromMillisecondsSinceEpoch(
            (doc.data() as Map)["timestamp"] ?? "Timestamp")),
      );
    }).toList();
  }

  // ssbSharesData from snapshot
  SsbSharesData _ssbSharesDataFromSnapshot(DocumentSnapshot snapshot) {
    return SsbSharesData(
      uid: FirebaseAuth.instance.currentUser.uid,
      name: (snapshot.data() as Map)["name"],
      wkn: (snapshot.data() as Map)["wkn"],
      zielkurs: (snapshot.data() as Map)["zielkurs"],
      empfehlung: (snapshot.data() as Map)["empfehlung"],
      id: snapshot.id,
      timestamp: DateTime.fromMillisecondsSinceEpoch(
          (snapshot.data() as Map)["timestamp"]),
    );
  }

  // get ssbShares stream - TODO cmn String für den Namen übergeben
  Stream<List<SsbShares>> get ssbShares {
    return ssbUsersCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(_ssbSharesListFromSnapshot);
  }

  // sortiert nach hot
  Stream<List<SsbShares>> get ssbSharesHot {
    return ssbUsersCollection
        .orderBy("empfehlung", descending: false)
        .snapshots()
        .map(_ssbSharesListFromSnapshot);
  }

  // get shares doc stream
  Stream<SsbSharesData> get ssbSharesData {
    return ssbUsersCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .snapshots()
        .map(_ssbSharesDataFromSnapshot);
  }
}
