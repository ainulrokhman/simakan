import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/auth_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/question_view.dart';
import 'package:simakan/ui/view/success_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class ChangePasswordView extends StatefulWidget {

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ganti Kata Sandi"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BaseView<AuthViewModel>(
        onModelReady: (data) {
        },
        builder: (context, data, child) =>
          ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _oldController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Kata Sandi Lama",
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
                      controller: _newController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Kata Sandi Baru",
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
                      controller: _confirmController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Konfirmasi Kata Sandi",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Color(0xffdedede)),
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        onPressed: () async {
                          await data.changePassword(
                              oldPassword: _oldController.text,
                              newPassword: _newController.text,
                              confirmPassword: _confirmController.text,
                              onSuccess: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuccessView(message: "Kata Sandi Berhasil di Ganti",)));
                              },
                              onError: (error) {
                                Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                              },
                              context: context
                          );
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: Colors.deepPurple,
                        elevation: 0,
                        padding: EdgeInsets.all(0),
                        height: 50,
                        minWidth: double.infinity,
                        child: Center(
                          child: Text(
                            "Update",
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
              ),
            )
          ),
      ),
    );
  }
}