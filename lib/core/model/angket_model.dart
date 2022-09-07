import 'dart:ui';

class AngketModel {
  int? respondenId;
  int? angketId;
  String? angketTitle;
  String? angketDescription;
  String? categoryName;
  String? angketStartDate;
  String? angketEndDate;
  String? status;
  int? isDoing;
  String? message;
  Color? messageColor;

  AngketModel(
      {this.respondenId,
        this.angketId,
        this.angketTitle,
        this.angketDescription,
        this.categoryName,
        this.angketStartDate,
        this.angketEndDate,
      this.status,
      this.isDoing,
      this.message,
      this.messageColor});

  AngketModel.fromJson(Map<String, dynamic> json) {
    respondenId = json['responden_id'];
    angketId = json['angket_id'];
    angketTitle = json['angket_title'];
    angketDescription = json['angket_description'];
    categoryName = json['category_name'];
    angketStartDate = json['angket_start_date'];
    angketEndDate = json['angket_end_date'];
    status = json['status'];
    isDoing = json['is_doing'];
    message = json['message'];
    messageColor = json['messageColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['responden_id'] = this.respondenId;
    data['angket_id'] = this.angketId;
    data['angket_title'] = this.angketTitle;
    data['angket_description'] = this.angketDescription;
    data['category_name'] = this.categoryName;
    data['angket_start_date'] = this.angketStartDate;
    data['angket_end_date'] = this.angketEndDate;
    data['status'] = this.status;
    data['is_doing'] = this.isDoing;
    data['message'] = this.message;
    data['messageColor'] = this.messageColor;
    return data;
  }
}