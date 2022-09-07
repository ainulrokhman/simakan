import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/model/angket_model.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/rule_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  
  List<AngketModel>? angket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Pengisian Angket"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BaseView<HomeViewModel>(
        onModelReady: (data) async {
          await data.getAngket(context);
          setState(() {
            angket = data.angket!.where((element) => element.isDoing == 2).toList();
          });
        },
        builder: (context, data, child) =>
          ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: angket == null ? Center(child: CircularProgressIndicator(),) : RefreshIndicator(
              onRefresh: () async{
                data.getAngket(context);
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      angket!.isEmpty ? Center(child: Text("Tidak ada data"),) : ListView.builder(
                          itemCount: angket!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => RuleView(
                                //   angketId: angket![index].angketId,
                                // ))).then((value) async {
                                //   await data.getAngket(context);
                                // });
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
                                      "${angket![index].angketTitle}",
                                      style: TextStyle(
                                          color: Colors.deepPurple,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      "${angket![index].angketDescription}",
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        "Sudah dikerjakan",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.green
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
                ),
              ),
            )
          ),
      ),
    );
  }
}