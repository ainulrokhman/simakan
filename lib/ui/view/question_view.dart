import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/view/success_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class QuestionView extends StatefulWidget {
  int? angketId;
  int? indexed;

  QuestionView({Key? key, required this.angketId, required this.indexed});

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int _groupValue = -1;
  String? _answer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AngketViewModel>(
      onModelReady: (data) async {
        await data.getQuestion(widget.angketId!, context);
      },
      builder: (context, data, child) => data.question == null ? Center(child: CircularProgressIndicator(),) : Scaffold(
      appBar: AppBar(
        title: Text("Pertanyaan ${widget.indexed! + 1} dari ${data.question!.length}"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200]!
                ),
                child: data.question!.isEmpty ? Center(child: Text("Tidak ada data"),) : Container(
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
                        "${data.question![widget.indexed!].questionnerTitle}",
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 16
                        ),
                      ),
                      SizedBox(height: 5,),
                      if(data.question![widget.indexed!].optionA != "") ...[
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (val) => setState(() => _groupValue = val as int),
                          title: Text("${data.question![widget.indexed!].optionA}", style: TextStyle(fontSize: 14),),
                        )
                      ],
                      if(data.question![widget.indexed!].optionB != "") ...[
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (val) => setState(() => _groupValue = val as int),
                          title: Text("${data.question![widget.indexed!].optionB}", style: TextStyle(fontSize: 14),),
                        )
                      ],
                      if(data.question![widget.indexed!].optionC != "") ...[
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: 2,
                          groupValue: _groupValue,
                          onChanged: (val) => setState(() => _groupValue = val as int),
                          title: Text("${data.question![widget.indexed!].optionC}", style: TextStyle(fontSize: 14),),
                        )
                      ],
                      if(data.question![widget.indexed!].optionD != "") ...[
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: 3,
                          groupValue: _groupValue,
                          onChanged: (val) => setState(() => _groupValue = val as int),
                          title: Text("${data.question![widget.indexed!].optionD}", style: TextStyle(fontSize: 14),),
                        )
                      ],
                      if(data.question![widget.indexed!].optionE != "") ...[
                        RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          value: 4,
                          groupValue: _groupValue,
                          onChanged: (val) => setState(() => _groupValue = val as int),
                          title: Text("${data.question![widget.indexed!].optionE}", style: TextStyle(fontSize: 14),),
                        )
                      ]
                    ],
                  ),
                ),
              ),
            )
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: MaterialButton(
              onPressed: data.question == null ? null : data.question!.isEmpty ? null : () async {
                if(_groupValue == -1) {
                  Toast.show("Mohon isi jawaban Anda", context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                } else {
                  await data.answerQuestion(
                    angketId: widget.angketId,
                    questionId: data.question![widget.indexed!].questionnerId,
                    value: _groupValue.toString(),
                    onSuccess: () {
                      if(widget.indexed! >= (data.question!.length - 1)) {
                        dialogSubmitAnswer(data, context);
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => QuestionView(
                          angketId: widget.angketId,
                          indexed: widget.indexed! + 1,
                        )));
                      }
                    },
                    onError: (error) {
                      Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    },
                    context: context
                  );
                }
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.deepPurple,
              elevation: 0,
              padding: EdgeInsets.all(0),
              height: 50,
              minWidth: double.infinity,
              child: Center(
                child: Text(
                  widget.indexed! >= (data.question!.length - 1) ? "Submit" : "Selanjutnya",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }

  dialogSubmitAnswer(AngketViewModel data, BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        title: new Text(
          'Submit',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        content: new Text(
          'Anda akan mengirimkan seluruh jawaban dari semua soal dan tidak bisa mengulangi soal lagi. Apakah anda yakin ingin mengirim seluruh jawaban?',
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
              await data.doing(
                  angketId: widget.angketId,
                  isDoing: 2,
                  onSuccess: () {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuccessView(message: "Anda Berhasil mengerjakan Angket",)));
                  },
                  onError: (error) {
                    Toast.show(error, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  },
                  context: context
              );
            },
            child: new Text(
              'Ok',
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