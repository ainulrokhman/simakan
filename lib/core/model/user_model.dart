class UserModel {
  int? siswaId;
  String? siswaNis;
  String? siswaName;
  String? className;
  String? siswaEmail;
  String? siswaPhoneNumber;
  String? siswaImages;

  UserModel(
      {this.siswaId,
        this.siswaNis,
        this.siswaName,
        this.className,
        this.siswaEmail,
        this.siswaPhoneNumber,
        this.siswaImages});

  UserModel.fromJson(Map<String, dynamic> json) {
    siswaId = json['siswa_id'];
    siswaNis = json['siswa_nis'];
    siswaName = json['siswa_name'];
    className = json['class_name'];
    siswaEmail = json['siswa_email'];
    siswaPhoneNumber = json['siswa_phone_number'];
    siswaImages = json['siswa_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siswa_id'] = this.siswaId;
    data['siswa_nis'] = this.siswaNis;
    data['siswa_name'] = this.siswaName;
    data['class_name'] = this.className;
    data['siswa_email'] = this.siswaEmail;
    data['siswa_phone_number'] = this.siswaPhoneNumber;
    data['siswa_images'] = this.siswaImages;
    return data;
  }
}