import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/auth_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<AuthViewModel>(
        builder: (context, data, child) => ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                      onPressed: () async {
                        await data.login(
                            user: _userController.text,
                            password: _passwordController.text,
                            onSuccess: () {
                              //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductView()));
                            },
                            onError: (error) {
                              Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                            },
                            context: context
                        );
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Colors.blue,
                      elevation: 0,
                      padding: EdgeInsets.all(0),
                      height: 50,
                      minWidth: double.infinity,
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      )
    );
  }
  
}