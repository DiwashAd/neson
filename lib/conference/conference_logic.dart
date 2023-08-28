import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';

final conferenceLogic = ChangeNotifierProvider((ref) => ConferenceLogic());

class ConferenceLogic extends ChangeNotifier {
  String foodImage = "";
  String entryImage = "";
  bool imageSelector = false;
  changeImage(bool value) {
    imageSelector = value;
  }

  Future downloadDocument(String url, String filename) async {
    try {
      Response response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      File file = File("/storage/emulated/0/Download/$filename");
      file.writeAsBytes(response.data);
      print("downloaded");
    } catch (e) {
      showToast("Error downloading file !,Please try again");
    }
  }
}
