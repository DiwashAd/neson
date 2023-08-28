import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/about_neson/about_neson.dart';
import 'package:neson/conference/conference.dart';
import 'package:neson/dashboard/dashboard.dart';
import 'package:neson/gallery/gallery.dart';
import 'package:neson/models/conference_model.dart';
import 'package:neson/models/posts_model.dart';
import 'package:neson/models/slider_model.dart';
import 'package:neson/profile/profile.dart';

final dashboardLogic = ChangeNotifierProvider((ref) => DashboardLogic());

class DashboardLogic extends ChangeNotifier {
  String dashboardImage = "";
  List<PostsModel> posts = [];
  List<SliderModel> sliders = [];

  fetchDashboardImage() async {
    print("fetching posts");
    List<SliderModel> postList = [];
    try {
      Response response = await Dio().get(
        "https://app.neson.org/api/sliders",
        options: Options(
          headers: {
            "accept": "application/json",
          },
        ),
      );
      print("///////////////// sliders /////////////////");
      print(response.data);
      print("///////////////// sliders /////////////////");
      for (var data in response.data['data']) {
        postList.add(SliderModel.fromJson(data));
      }
      sliders = postList;
      notifyListeners();
    } on DioException catch (e) {
      print(e.error);
      print(e.response);
      print("fetching posts exceptiom");
    }
  }

  fetchPosts() async {
    print("fetching posts");
    List<PostsModel> postList = [];
    try {
      Response response = await Dio().get(
        "https://app.neson.org/api/posts",
        options: Options(
          headers: {
            "accept": "application/json",
          },
        ),
      );
      print("///////////////// POSTS /////////////////");
      print(response.data);
      print("///////////////// POSTS /////////////////");

      for (var data in response.data['data']) {
        postList.add(PostsModel.fromJson(data));
      }
      posts = postList;
      notifyListeners();
    } on DioException catch (e) {
      print("fetching posts exceptiom");
    }
  }

  PostsModel? aboutNeson;

  fetchAboutNeson() async {
    print("fetching posts");
    PostsModel aboutUs;
    try {
      var dio = Dio();
      var response = await dio.request(
        'https://app.neson.org/api/page?page=about-us-app',
        options: Options(
          method: 'GET',
        ),
      );

      // if (response.statusCode == 200) {
      //   print(json.encode(response.data));
      // }
      // else {
      //   print(response.statusMessage);
      // }
      // Response response = await Dio().get(
      //   "https://app.neson.org/api/page?page=about-us-app",
      //   options: Options(
      //     headers: {
      //       "accept": "application/json",
      //     },
      //   ),
      // );
      print("///////////////// about us /////////////////");
      print(response.data);
      print("///////////////// about us /////////////////");
      aboutUs = PostsModel.fromJson(response.data['data']);
      aboutNeson = aboutUs;
      notifyListeners();
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.response?.statusCode);
      print("fetching posts exceptiom");
    }
  }

  ConferenceModel? conference;

  fetchConference() async {
    try {
      var headers = {'Accept': 'application/json'};
      var dio = Dio();
      var response = await dio.request(
        'https://app.neson.org/api/event',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      // if (response.statusCode == 200) {
      //   print(json.encode(response.data));
      // }
      // else {
      //   print(response.statusMessage);
      // }
      // Response response = await Dio().get(
      //   "https://app.neson.org/api/event",
      //   options: Options(
      //     headers: {
      //       "accept": "application/json",
      //     },
      //   ),
      // );
      print("///////////////// conference /////////////////");
      print(response.data);
      print("///////////////// conference /////////////////");
      conference = ConferenceModel.fromJson(response.data['data']);
      notifyListeners();
    } on DioException catch (e) {
      print("fetching posts exceptiom");
    }
  }

  ///Bottom Navigation Bar Items
  List body = [
    const Dashboard(),
    const ConferenceView(),
    const Gallery(),
    const Profile(),
    const AboutNeson(),
    Members(),
  ];
  Widget bodyWidget = const Dashboard();
  int selectedBody = 0;

  changeBody(index) {
    bodyWidget = body[index];
    selectedBody = index;
    notifyListeners();
  }
}
