import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/repository/auth_repository.dart';
import 'package:simakan/core/viewmodel/base_viewmodel.dart';
import 'package:simakan/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _authRepository = locator<AuthRepository>();

  Future<bool> login({
    String? user,
    String? password,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var request = await _authRepository.login(user!, password!, context);
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