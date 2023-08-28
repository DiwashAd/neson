import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/models/gallery_model.dart';

final galleryLogic = ChangeNotifierProvider((ref) => GalleryLogic());

class GalleryLogic extends ChangeNotifier {
  List<GalleryModel> galleryList = [];

  fetchGallery() async {
    print("fetching members");
    List<GalleryModel> galleries = [];
    try {
      Response response =
          await Dio().get("https://app.neson.org/api/galleries");
      print(response);
      for (var data in response.data['data']) {
        galleries.add(GalleryModel.fromJson(data));
      }
      galleryList = galleries;
      notifyListeners();
    } on DioException catch (e) {
      print("fetching posts exceptiom");
    }
  }
}
