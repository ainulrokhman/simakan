import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/question_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class RuleView extends StatefulWidget {
  int? angketId;

  RuleView({Key? key, required this.angketId});

  @override
  _RuleViewState createState() => _RuleViewState();
}

class _RuleViewState extends State<RuleView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aturan"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BaseView<AngketViewModel>(
        onModelReady: (data) {
        },
        builder: (context, data, child) =>
          ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200]!
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tata cara pengerjaan Angket",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "1. Isi sesuai jawaban yang sudah di sediakan",
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "2. Pastikan mempunyai koneksi internet yang stabil",
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "3. Baca soal yang teliti dan hati-hati",
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "4. Kerjakan terlebih dahulu soal yang dianggap mudah",
                    ),
                    SizedBox(height: 5,),
                    Text(
                      "5. Jangan biarkan ada jawaban yang kosong",
                    ),
                    SizedBox(height: 50,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        onPressed: () async {
                          await data.doing(
                            angketId: widget.angketId,
                            isDoing: 1,
                            onSuccess: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => QuestionView(
                                angketId: widget.angketId,
                                indexed: 0,
                              )));
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
                            "Mulai kerjakan",
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