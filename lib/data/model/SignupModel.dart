// ignore_for_file: file_names

class SignupModel {
  String? email;
  String? password;
  String? repassword;

  SignupModel({this.email, this.password, this.repassword});

  SignupModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    repassword = json['repassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['repassword'] = repassword;
    return data;
  }
}
