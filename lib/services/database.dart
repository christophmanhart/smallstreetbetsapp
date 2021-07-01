import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:smallstreetbetsapp/models/ssbshares.dart';
import 'package:smallstreetbetsapp/models/ssbuser.dart';
import 'package:smallstreetbetsapp/models/the_user.dart';
import 'package:smallstreetbetsapp/shared/empfehlung.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Ssbuser
  //collection reference
  final CollectionReference ssbusersCollection =
      FirebaseFirestore.instance.collection('ssbusers');

  Future updateUserData(String name) async {
    return await ssbusersCollection.doc(uid).set({
      "name": name,
    });
  }

  //ssbuser list from snapshot
  List<Ssbuser> _ssbuserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Ssbuser(
        name: (doc.data() as Map)["name"] ?? "",
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: (snapshot.data() as Map)["name"],
    );
  }

  // get ssbusers stream
  Stream<List<Ssbuser>> get ssbusers {
    return ssbusersCollection.snapshots().map(_ssbuserListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return ssbusersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  //SsbShares
  //collection reference
  final CollectionReference ssbSharesCollection =
      FirebaseFirestore.instance.collection('ssbshares');

  Future updateSharesData(
      String name, String wkn, double zielkurs, Empfehlung empfehlung) async {
    return await ssbSharesCollection.doc(uid).set({
      "name": name,
      "wkn": wkn,
      "zielkurs": zielkurs,
      "empfehlung": empfehlung.toString(),
    });
  }

  //ssbShares list from snapshot
  List<SsbShares> _ssbSharesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return SsbShares(
        name: (doc.data() as Map)["name"] ?? "Name",
        wkn: (doc.data() as Map)["wkn"] ?? "WKN",
        zielkurs: (doc.data() as Map)["zielkurs"] ?? 0.00,
        empfehlung: EnumToString.fromString(Empfehlung.values, (doc.data() as Map)["empfehlung"] ?? "buy"),
      );
    }).toList();
  }

  // ssbSharesData from snapshot
  SsbSharesData _ssbSharesDataFromSnapshot(DocumentSnapshot snapshot) {
    return SsbSharesData(
      uid: uid,
      name: (snapshot.data() as Map)["name"],
      wkn: (snapshot.data() as Map)["wkn"],
      zielkurs: (snapshot.data() as Map)["zielkurs"],
      empfehlung: (snapshot.data() as Map)["empfehlung"],
    );
  }

  // get ssbShares stream
  Stream<List<SsbShares>> get ssbShares {
    return ssbSharesCollection.snapshots().map(_ssbSharesListFromSnapshot);
  }

  // get shares doc stream
  Stream<SsbSharesData> get ssbSharesData {
    return ssbSharesCollection
        .doc(uid)
        .snapshots()
        .map(_ssbSharesDataFromSnapshot);
  }
}
