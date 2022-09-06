import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/model/angket_model.dart';
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

  Future getAngket(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    angket = await _angketRepository.getAngket(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}