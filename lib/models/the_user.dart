class TheUser {
  final String uid;

  // controlling what user properties we want to have from the signed in user
  TheUser({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int alter;

  UserData({this.uid, this.name, this.alter});
}
