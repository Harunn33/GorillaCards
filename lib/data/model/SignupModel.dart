class SignupModel {
  String? email;
  String? password;
  String? passwordAgain;

  SignupModel({this.email, this.password, this.passwordAgain});

  SignupModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    passwordAgain = json['passwordAgain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['passwordAgain'] = passwordAgain;
    return data;
  }
}
