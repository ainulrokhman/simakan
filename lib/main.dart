import 'package:flutter/material.dart';
import 'package:simakan/locator.dart';
import 'package:simakan/ui/view/login_view.dart';
import 'package:simakan/ui/view/splashscreen_view.dart';

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simakan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(),
    );
  }
}
