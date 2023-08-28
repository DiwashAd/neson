import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final profileLogic = ChangeNotifierProvider((ref) => ProfileLogic());

class ProfileLogic extends ChangeNotifier {
  bool isLoggedIn = false;
  UserModel? user;

  setLoggedInFalse() {
    isLoggedIn = false;
    user = null;
    notifyListeners();
  }

  setUser() async {
    print("setting up user");
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? loggedIn = pref.getBool("isLoggedIn");
    String? userData = pref.getString("user");
    if (userData != null) {
      isLoggedIn = true;
      Map<String, dynamic> data = jsonDecode(userData);
      print(data);
      UserModel usr = UserModel.fromJson(data);
      user = usr;
    }
    notifyListeners();
  }
}
