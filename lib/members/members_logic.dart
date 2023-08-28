import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/models/members_mdoel.dart';

final membersLogic = ChangeNotifierProvider((ref) => MembersLogic());

class MembersLogic extends ChangeNotifier {
  List<MembersModel> normalMembers = [];
  List<MembersModel> executiveMembers = [];

  String executiveDate = "";
  String normalDate = "";
  fetchMembers() async {
    print("fetching members");
    List<MembersModel> normal = [];
    List<MembersModel> executive = [];
    try {
      Response response = await Dio().get("https://app.neson.org/api/members");
      for (var data in response.data['data']) {
        if (data['type'] == "Normal Member") {
          normalDate = data['duration'];
          notifyListeners();
          for (var mem in data['members']) {
            normal.add(MembersModel.fromJson(mem));
          }
        } else if (data['type'] == "Executive Committee") {
          executiveDate = data['duration'];
          print(executiveDate);
          notifyListeners();
          for (var mem in data['members']) {
            executive.add(MembersModel.fromJson(mem));
          }
        }
      }
      normalMembers = normal;
      executiveMembers = executive;
      print(normalMembers.length);
      print(executiveMembers.length);
      notifyListeners();
    } on DioException catch (e) {
      print("fetching posts exceptiom");
    }
  }
}
