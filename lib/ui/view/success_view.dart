import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/question_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class SuccessView extends StatefulWidget {

  @override
  _SuccessViewState createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Color(0xffe1f4e5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/success.gif"),
            Text(
              "Berhasil",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Anda Berhasil mengerjakan Angket",
            ),
            SizedBox(height: 50,),
            Container(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Colors.green,
                  elevation: 0,
                  padding: EdgeInsets.all(0),
                  height: 50,
                  minWidth: double.infinity,
                  child: Center(
                    child: Text(
                      "Kembali ke Home",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}