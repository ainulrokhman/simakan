import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/model/user_model.dart';
import 'package:simakan/core/repository/auth_repository.dart';
import 'package:simakan/core/repository/user_repository.dart';
import 'package:simakan/core/viewmodel/base_viewmodel.dart';
import 'package:simakan/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final UserRepository _userRepository = locator<UserRepository>();

  UserModel? user;

  Future<bool> login({
    String? nis,
    String? password,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var request = await _authRepository.login(nis!, password!, context);
    setState(ViewState.Idle);
    if (request) {
      return onSuccess();
    } else {
      onError(prefs.getString('message')!);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future getUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    user = await _userRepository.getUser(context);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<bool> changePassword({
    String? oldPassword,
    String? newPassword,
    String? confirmPassword,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(oldPassword == "" || newPassword == "" || confirmPassword == "") {
      onError("Mohon lengkapi data");
      return false;
    }
    if(newPassword != confirmPassword) {
      onError("Kata sandi baru dengan konfirmasi kata sandi tidak sesuai");
      return false;
    }
    setState(ViewState.Busy);
    var request = await _authRepository.changePassword(oldPassword!, newPassword!, context);
    setState(ViewState.Idle);
    if (request) {
      return onSuccess();
    } else {
      onError(prefs.getString('message')!);
      setState(ViewState.Idle);
      return false;
    }
  }

  logout() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> changePhotoProfile({
    File? file,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var request = await _authRepository.changePhoto(file!, context);
    setState(ViewState.Idle);
    if (request) {
      return onSuccess();
    } else {
      onError(prefs.getString('message')!);
      setState(ViewState.Idle);
      return false;
    }
  }

  Future<bool> updateProfile({
    String? name,
    String? email,
    String? phoneNumber,
    required Function() onSuccess,
    required Function(String) onError,
    required BuildContext context
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(ViewState.Busy);
    var request = await _authRepository.updateProfile(name!, email!, phoneNumber!, context);
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