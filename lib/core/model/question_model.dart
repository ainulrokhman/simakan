class QuestionModel {
  int? questionnerId;
  String? questionnerTitle;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? optionE;

  QuestionModel(
      {this.questionnerId,
        this.questionnerTitle,
        this.optionA,
        this.optionB,
        this.optionC,
        this.optionD,
        this.optionE});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    questionnerId = json['questionner_id'];
    questionnerTitle = json['questionner_title'];
    optionA = json['option_a'];
    optionB = json['option_b'];
    optionC = json['option_c'];
    optionD = json['option_d'];
    optionE = json['option_e'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionner_id'] = this.questionnerId;
    data['questionner_title'] = this.questionnerTitle;
    data['option_a'] = this.optionA;
    data['option_b'] = this.optionB;
    data['option_c'] = this.optionC;
    data['option_d'] = this.optionD;
    data['option_e'] = this.optionE;
    return data;
  }
}