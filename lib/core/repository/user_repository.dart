import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/api.dart';
import 'package:simakan/core/helper/dio_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simakan/core/model/user_model.dart';

class UserRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<UserModel?> getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().user,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              }),
          data: {
            'siswa_id': prefs.getInt('siswa_id')
          }).timeout(Duration(seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        notifyListeners();
        final Map<String, dynamic> parsed = response!.data['data'];
        final data = UserModel.fromJson(parsed);
        return data;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return null;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('error', errorMessage);
      return null;
    }
  }
}