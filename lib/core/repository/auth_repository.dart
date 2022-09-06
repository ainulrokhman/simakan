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
}