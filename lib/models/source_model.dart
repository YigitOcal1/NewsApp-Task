import 'dart:convert';

class SourceModel {
  String? id;
  String? name;

  SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toMap() => {
        'id': id ?? "",
        'name': name ?? "",
      };
}
