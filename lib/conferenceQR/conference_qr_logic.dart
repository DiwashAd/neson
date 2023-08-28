import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final conferenceQRLogic = ChangeNotifierProvider((ref) => ConferenceQRLogic());

class ConferenceQRLogic extends ChangeNotifier {
  Map data = {};

  bool isRegistered = false;

  getConferenceQR() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token != null) {
      try {
        Response response = await Dio().get(
          "https://app.neson.org/api/user/conference",
          options: Options(
            headers: {
              "authorization": "Bearer $token",
            },
          ),
        );
        print(response.data);
        if (response.data['status']) {
          isRegistered = true;
          data = response.data['data'];
        } else {
          isRegistered = false;
          data = {};
        }
        notifyListeners();
      } on DioException catch (e) {
        showToast("Error fetching QR code", position: ToastPosition.bottom);
      }
    }
  }
}
