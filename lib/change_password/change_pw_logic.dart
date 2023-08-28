import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final changePasswordLogic =
    ChangeNotifierProvider((ref) => ChangePasswordLogic());

class ChangePasswordLogic extends ChangeNotifier {
  bool obscure1 = true;
  bool obscure2 = true;
  bool obscure3 = true;

  toggleObscure({bool? obs1, bool? obs2, bool? obs3}) {
    obscure1 = obs1 ?? obscure1;
    obscure2 = obs2 ?? obscure2;
    obscure3 = obs3 ?? obscure3;
    notifyListeners();
  }

  Future changePassword(
      String password, String newPassword, String confirmPassword) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      FormData formData = FormData.fromMap({
        "old_password": password,
        "password": newPassword,
        "password_confirmation": confirmPassword,
      });
      try {
        Response response = await Dio().post(
          "https://app.neson.org/api/auth/change-password",
          data: formData,
          options: Options(
            headers: {
              "accept": "application/json",
              "authorization": "Bearer $token",
            },
          ),
        );
        return response.data;
      } on DioException catch (e) {
        print(e.response);
        print("111111111111111111111");
        return e.response?.data ?? {};
      }
    } else {
      return false;
    }
  }
}
