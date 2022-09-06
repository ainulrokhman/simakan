import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/api.dart';
import 'package:simakan/core/helper/dio_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simakan/core/model/angket_model.dart';
import 'package:simakan/core/model/question_model.dart';
import 'package:simakan/core/model/user_model.dart';

class AngketRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<List<AngketModel>> getAngket(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().angket,
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
        Iterable data = response!.data['data'];
        List<AngketModel> listData = data.map((map) => AngketModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return [];
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('error', errorMessage);
      return [];
    }
  }

  Future<List<QuestionModel>> getQuestion(int angketId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio.post(Api().question,
          options: Options(
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
              }),
          data: {
            'angket_id': angketId
          }).timeout(Duration(seconds: Api().timeout));
      if (response!.data['isSuccess'] == true) {
        notifyListeners();
        Iterable data = response!.data['data'];
        List<QuestionModel> listData = data.map((map) => QuestionModel.fromJson(map)).toList();
        return listData;
      } else {
        print(response!.data['status']);
        prefs.setString('message', response!.data['message']);
        return [];
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('error', errorMessage);
      return [];
    }
  }
}