import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simakan/core/constant/viewstate.dart';
import 'package:simakan/core/viewmodel/angket_viewmodel.dart';
import 'package:simakan/core/viewmodel/home_viewmodel.dart';
import 'package:simakan/ui/base_view.dart';
import 'package:simakan/ui/widget/modal_progress.dart';
import 'package:toast/toast.dart';

class QuestionView extends StatefulWidget {
  int? angketId;

  QuestionView({Key? key, required this.angketId});

  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pertanyaan"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BaseView<AngketViewModel>(
        onModelReady: (data) {
          data.getQuestion(widget.angketId!, context);
        },
        builder: (context, data, child) =>
          ModalProgress(
            inAsyncCall: data.state == ViewState.Busy ? true : false,
            child: data.question == null ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200]!
                ),
                child: data.question!.isEmpty ? Center(child: Text("Tidak ada data"),) : ListView.builder(
                    itemCount: data.question!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
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
                              "${data.question![index].questionnerTitle}",
                            ),
                            SizedBox(height: 5,),
                            _myRadioButton(
                              title: "${data.question![index].optionA}",
                              value: 0,
                              onChanged: (newValue) => setState(() => _groupValue = newValue),
                            ),
                            _myRadioButton(
                              title: "${data.question![index].optionC}",
                              value: 2,
                              onChanged: (newValue) => setState(() => _groupValue = newValue),
                            ),
                            _myRadioButton(
                              title: "${data.question![index].optionD}",
                              value: 3,
                              onChanged: (newValue) => setState(() => _groupValue = newValue),
                            ),
                            _myRadioButton(
                              title: "${data.question![index].optionE}",
                              value: 4,
                              onChanged: (newValue) => setState(() => _groupValue = newValue),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            )
          ),
      ),
    );
  }

  Widget _myRadioButton({String? title, int? value, Function? onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: null,//onChanged,
      title: Text(title!),
    );
  }
}