import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simakan/ui/view/home_view.dart';
import 'package:simakan/ui/view/login_view.dart';

class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  @override
  void initState(){
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async{
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
        if(prefs.getBool('is_login') == true) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeView()));
        } else {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginView()));
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", width: 200),
          ],
        ),
      ),
    );
  }
}