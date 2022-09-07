import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/api.dart';
import 'package:simakan/core/helper/dio_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<bool> login(String nis, String password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().login,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              }),
          data: {
            'nis': nis,
            'password': password
          }).timeout(Duration(seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        prefs.setBool('is_login', true);
        prefs.setInt('siswa_id', response!.data['data']['siswa_id']);
        return true;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().changePassword,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              }),
          data: {
            'old_password': oldPassword,
            'new_password': newPassword,
            'siswa_id': prefs.getInt('siswa_id')
          }).timeout(Duration(seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        return true;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }

  Future<bool> updateProfile(String name, String email, String phoneNumber, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().updateprofile,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              }),
          data: {
            'name': name,
            'email': email,
            'phone': phoneNumber,
            'siswa_id': prefs.getInt('siswa_id')
          }).timeout(Duration(seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        return true;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }

  Future<bool> changePhoto(File file, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String fileName = file.path.split('/').last;
    try {
      response = await dio.post(Api().changePhoto,
          options: Options(
              headers: {
                "Accept": "application/json",
                //"Content-Type": "application/json"
              }),
          data: {
            'siswa_id': prefs.getInt('siswa_id'),
            'images': await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          }).timeout(Duration(seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        return true;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      return false;
    }
  }
}