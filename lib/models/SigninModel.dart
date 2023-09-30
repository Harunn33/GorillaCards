// ignore_for_file: file_names

import 'dart:convert';

SigninModel signinModelFromJson(String str) =>
    SigninModel.fromJson(json.decode(str));

String signinModelToJson(SigninModel data) => json.encode(data.toJson());

class SigninModel {
  String email;
  String password;

  SigninModel({
    required this.email,
    required this.password,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) => SigninModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
