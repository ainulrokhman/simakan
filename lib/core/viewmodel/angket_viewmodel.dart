import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/model/angket_model.dart';
import 'package:simakan/core/model/question_model.dart';
import 'package:simakan/core/model/user_model.dart';
import 'package:simakan/core/repository/angket_repository.dart';
import 'package:simakan/core/repository/auth_repository.dart';
import 'package:simakan/core/repository/user_repository.dart';
import 'package:simakan/core/viewmodel/base_viewmodel.dart';
import 'package:simakan/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AngketViewModel extends BaseViewModel {
  final AngketRepository _angketRepository = locator<AngketRepository>();

  List<AngketModel>? angket;
  List<QuestionModel>? question;

  Future getAngket(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    angket = await _angketRepository.getAngket(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getQuestion(int angketId, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    question = await _angketRepository.getQuestion(angketId, context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<bool> doing({
    required int? angketId,
    required int? isDoing,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var request = await _angketRepository.doing(angketId!, isDoing!, context);
    setState(ViewState.Idle);
    if (request) {
      return onSuccess();
    } else {
      onError(prefs.getString('message')!);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> answerQuestion({
    int? angketId,
    int? questionId,
    String? value,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var request = await _angketRepository.answerQuestion(angketId!, questionId!, value!, context);
    setState(ViewState.Idle);
    if (request) {
      return onSuccess();
    } else {
      onError(prefs.getString('message')!);
      setState(ViewState.Idle);
      return false;
    }
  }
}