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

class HomeViewModel extends BaseViewModel {
  final UserRepository _userRepository = locator<UserRepository>();
  final AngketRepository _angketRepository = locator<AngketRepository>();

  UserModel? user;
  List<AngketModel>? angket;

  Future getAngket(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    angket = await _angketRepository.getAngket(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    user = await _userRepository.getUser(context);
    notifyListeners();
    setState(ViewState.Idle);
  }
}