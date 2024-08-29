import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    uid: '',
    name: "",
    email: "",
    password: "",
  );

  User get user => _user;

  void setUserByModel(User user) {
    _user = user;
    notifyListeners();
  }
}
