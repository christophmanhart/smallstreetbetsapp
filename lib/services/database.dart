import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smallstreetbetsapp/models/ssbuser.dart';
import 'package:smallstreetbetsapp/models/the_user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference ssbusersCollection =
      FirebaseFirestore.instance.collection('ssbusers');

  Future updateUserData(String name, int alter) async {
    return await ssbusersCollection.doc(uid).set({
      "name": name,
      "alter": alter,
    });
  }

  //ssbuser list from snapshot
  List<Ssbuser> _ssbuserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Ssbuser(
        name: doc.data()["name"] ?? "",
        alter: doc.data()["alter"] ?? 0,
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()["name"],
      alter: snapshot.data()["alter"],
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
}
