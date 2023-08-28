import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final loginLogic = ChangeNotifierProvider((ref) => LoginLogic());

class LoginLogic extends ChangeNotifier {
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  bool obscure = true;
  bool signingIn = false;

  login(String username, String password) async {
    print("adsasdasdadas");
    print(username);
    print(password);
    try {
      Response response =
          await Dio().post("https://app.neson.org/api/auth/login", data: {
        "email": username,
        "password": password,
      });
      print(response);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", response.data['accessToken']);
      pref.setBool("isLoggedIn", true);
      pref.setString("user", jsonEncode(response.data['userData']));
      showToast("Logged in successfully", position: ToastPosition.bottom);
      return true;
    } on DioException catch (e) {
      print(e.error);
      print(e.response);
      print(e.message);
      print(e.response?.statusCode);
      print("error");
      showToast("Error Signing in please try again",
          position: ToastPosition.bottom);
      return false;
    }
  }
}
