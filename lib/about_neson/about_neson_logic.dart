import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/models/posts_model.dart';

final aboutLogic = ChangeNotifierProvider((ref) => AboutLogic());

class AboutLogic extends ChangeNotifier {
  PostsModel? aboutNeson;

  fetchAboutNeson() async {
    PostsModel aboutUs;
    try {
      Response response = await Dio()
          .get("https://app.neson.org/api/page?page=about-us-app");
      aboutUs = PostsModel.fromJson(response.data['data']);
      aboutNeson = aboutUs;
      notifyListeners();
    } on DioException catch (e) {
      print("fetching posts exceptiom");
    }
  }
}
