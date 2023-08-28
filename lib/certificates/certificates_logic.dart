import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/models/certificates_mdoel.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final certificates = ChangeNotifierProvider((ref) => CertificatesLogic());

class CertificatesLogic extends ChangeNotifier {
  bool hasCitizenship = false;
  bool hasPassport = false;
  bool hasDrivingLicense = false;
  CertificateModel? drivingLicense;
  CertificateModel? citizenship;
  CertificateModel? passport;
  List<CertificateModel> certs = [];

  getCertificates() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      try {
        Response response = await Dio().get(
          "https://app.neson.org/api/certificates",
          options: Options(
            headers: {
              "accept": "application/json",
              "authorization": "Bearer $token",
            },
          ),
        );
        print(response);
        for (var data in response.data['certificates']) {
          if (data['type'].toString().toLowerCase() ==
              'driving_license'.toLowerCase()) {
            hasDrivingLicense = true;
            CertificateModel dl = CertificateModel.fromJson(data);
            drivingLicense = dl;
            certs.add(dl);
            notifyListeners();
          }
          if (data['type'].toString().toLowerCase() ==
              'passport'.toLowerCase()) {
            hasPassport = true;
            CertificateModel pp = CertificateModel.fromJson(data);
            passport = pp;
            certs.add(pp);
            notifyListeners();
          }
          if (data['type'].toString().toLowerCase() ==
              'citizenship'.toLowerCase()) {
            hasCitizenship = true;
            CertificateModel ct = CertificateModel.fromJson(data);
            citizenship = ct;
            certs.add(ct);
            notifyListeners();
          }
        }
        notifyListeners();
      } on DioException catch (e) {
        print(e.response);

        showToast("Error Signing in please try again",
            position: ToastPosition.bottom);
      }
    }
  }

  Future<bool> uploadPassport(File file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      print(token);
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "certificate_type": "passport",
        "certificate":
            await MultipartFile.fromFile(file.path, filename: fileName),
      });
      try {
        Response response = await Dio().post(
          "https://app.neson.org/api/certificate/upload",
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
          getCertificates();
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

  Future<bool> uploadCitizenship(File file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      print(token);
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "certificate_type": "citizenship",
        "certificate":
            await MultipartFile.fromFile(file.path, filename: fileName),
      });
      try {
        Response response = await Dio().post(
          "https://app.neson.org/api/certificate/upload",
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
          getCertificates();
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

  Future<bool> uploadLicense(File file) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      print(token);
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "certificate_type": "driving_license",
        "certificate":
            await MultipartFile.fromFile(file.path, filename: fileName),
      });
      try {
        Response response = await Dio().post(
          "https://app.neson.org/api/certificate/upload",
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
          getCertificates();
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

  Future<bool> uploadCert(File file, String cert) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    if (token != null) {
      print(token);
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "certificate_type": cert,
        "certificate":
            await MultipartFile.fromFile(file.path, filename: fileName),
      });
      try {
        Response response = await Dio().post(
          "https://app.neson.org/api/certificate/upload",
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
          getCertificates();
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
      return true;
    } catch (e) {
      showToast("Error downloading file !,Please try again");
      return false;
    }
  }
}
