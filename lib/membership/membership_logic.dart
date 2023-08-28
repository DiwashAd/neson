import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/models/membership.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final membershipLogic = ChangeNotifierProvider((ref) => MembershipLogic());

class MembershipLogic extends ChangeNotifier {
  MembershipModel? mem;

  Future<bool> uploadImage(File file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      print(token);
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "voucher": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      try {
        Response response = await Dio().post(
          "https://app.neson.org/api/membership/payment",
          data: formData,
          options: Options(
            headers: {
              "accept": "application/json",
              "authorization": "Bearer $token",
            },
          ),
        );
        if (response.data['status']) {
          print("456545654565456545");
          return true;
        } else {
          print("7897+"
              "+++++++");

          return false;
        }
      } on DioException catch (e) {
        print(e.response);
        print("111111111111111111111");
        return false;
      }
    } else {
      return false;
    }
  }

  getMembership() async {
    MembershipModel membership = MembershipModel();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token != null) {
      print(token);
      print({
        "authorization": "Bearer $token",
      });
      try {
        Response response = await Dio().get(
          "https://app.neson.org/api/membership",
          options: Options(
            headers: {
              "accept": "application/json",
              "authorization": "Bearer $token",
            },
          ),
        );
        print(token);
        membership =
            MembershipModel.fromJson(response.data['data']['membership']);
        mem = membership;

        notifyListeners();
      } on DioException catch (e) {
        print(e.response);
        print(e.error);
        print(e.message);
        showToast("Error fetching membership data",
            position: ToastPosition.bottom);
      }
    }
  }
}
