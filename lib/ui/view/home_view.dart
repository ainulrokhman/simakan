import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/auth_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/change_password_view.dart';
import 'package:simakan/ui/view/edit_profile_view.dart';
import 'package:simakan/ui/view/history_view.dart';
import 'package:simakan/ui/view/login_view.dart';
import 'package:simakan/ui/view/rule_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String status = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              dialogLogout(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ))
        ],
      ),
      body: BaseView<HomeViewModel>(
        onModelReady: (data) {
          data.getUser(context);
          data.getAngket(context);
        },
        builder: (context, data, child) =>
          ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.user == null || data.angket == null ? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
              onRefresh: () async{
                data.getUser(context);
                data.getAngket(context);
              },
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)
                            )
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: InkWell(
                                      onTap: () => showModalProfile(data, context),
                                      child: Container(
                                        child: Image.network("${data.user!.siswaImages}", width: 50, height: 50, fit: BoxFit.cover,),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hi, ${data.user!.siswaName}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text(
                                        "Selamat datang",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //menu
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Angket Anda",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryView()));
                                  },
                                  child: Text(
                                    "Riwayat",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.deepPurple
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            data.angket!.isEmpty ? Center(child: Text("Tidak ada data"),) : ListView.builder(
                                itemCount: data.angket!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  if(data.angket![index].status != "OK") {
                                    data.angket![index].message = data.angket![index].status;
                                    data.angket![index].messageColor = Colors.red;
                                  } else {
                                    if(data.angket![index].isDoing == 2) {
                                      data.angket![index].message = "Sudah dikerjakan";
                                      data.angket![index].messageColor = Colors.green;
                                    } else if(data.angket![index].isDoing == 1){
                                      data.angket![index].message = "Sedang dikerjakan";
                                      data.angket![index].messageColor = Colors.deepPurple;
                                    } else {
                                      data.angket![index].message = "Batas Waktu : ${data.angket![index].angketEndDate}";
                                      data.angket![index].messageColor = Colors.black;
                                    }
                                  }
                                  return InkWell(
                                    onTap: () {
                                      if(data.angket![index].status != "OK") {
                                        Toast.show(data.angket![index].status, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                      } else {
                                        if(data.angket![index].isDoing == 2) {
                                          Toast.show("Anda sudah mengerjakan Angket ini", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                                        } else {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RuleView(
                                            angketId: data.angket![index].angketId,
                                          ))).then((value) async {
                                            await data.getAngket(context);
                                            await data.getUser(context);
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200]!,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data.angket![index].angketTitle}",
                                            style: TextStyle(
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            "${data.angket![index].angketDescription}",
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: double.infinity,
                                            child: Text(
                                              "${data.angket![index].message}",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color: data.angket![index].messageColor
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ),
      ),
    );
  }

  showModalProfile(HomeViewModel data, BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (BuildContext bc){
          return SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.deepPurple,),
                        title: Text('Edit Profil', style: TextStyle(fontSize: 12),),
                        onTap: () async {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileView())).then((value) async {
                            await data.getAngket(context);
                            await data.getUser(context);
                          });
                        }
                    ),
                    ListTile(
                      leading: Icon(Icons.lock, color: Colors.deepPurple),
                      title: Text('Ganti Kata Sandi', style: TextStyle(fontSize: 12),),
                      onTap: () async {
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordView())).then((value) async {
                          await data.getAngket(context);
                          await data.getUser(context);
                        });
                      },
                    ),
                  ],
                ),
              )
          );
        }
    );
  }

  dialogLogout(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        title: new Text(
          'Keluar Akun',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        content: new Text(
          'Apakah Anda yakin ingin keluar?',
          style: TextStyle(
              color: Colors.grey
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            child: new Text(
              'Batalkan',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await AuthViewModel().logout();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));
            },
            child: new Text(
              'Yakin',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
      ),
    );
  }
}