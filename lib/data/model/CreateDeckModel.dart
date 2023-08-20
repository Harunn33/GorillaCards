// ignore_for_file: file_names

class CreateDeckModel {
  String? name;
  String? description;

  CreateDeckModel({this.name, this.description});

  CreateDeckModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
