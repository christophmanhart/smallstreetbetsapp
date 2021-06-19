import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smallstreetbetsapp/models/the_user.dart';
import 'package:smallstreetbetsapp/screens/home/home.dart';

import 'authentication/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    print(user);
    // return either Main or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
