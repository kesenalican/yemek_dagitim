// To parse this JSON data, do
//
//     final ConsumerModel = ConsumerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConsumerModel ConsumerModelFromJson(String str) =>
    ConsumerModel.fromJson(json.decode(str));

String ConsumerModelToJson(ConsumerModel data) => json.encode(data.toJson());

class ConsumerModel {
  final List<ConsumerListModel> data;
  final bool status;
  final dynamic message;

  ConsumerModel({
    required this.data,
    required this.status,
    this.message,
  });

  factory ConsumerModel.fromJson(Map<String, dynamic> json) => ConsumerModel(
        data:
            List<ConsumerListModel>.from(json["data"].map((x) => ConsumerListModel.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

 class ConsumerListModel {
  final String identityNumber;
  final String name;
  final String address;
  final dynamic coordinate;
  final int id;
  final DateTime createDate;
  final bool isActive;

  ConsumerListModel({
    required this.identityNumber,
    required this.name,
    required this.address,
    this.coordinate,
    required this.id,
    required this.createDate,
    required this.isActive,
  });

  factory ConsumerListModel.fromJson(Map<String, dynamic> json) => ConsumerListModel(
        identityNumber: json["identityNumber"],
        name: json["name"],
        address: json["address"],
        coordinate: json["coordinate"],
        id: json["id"],
        createDate: DateTime.parse(json["createDate"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "identityNumber": identityNumber,
        "name": name,
        "address": address,
        "coordinate": coordinate,
        "id": id,
        "createDate": createDate.toIso8601String(),
        "isActive": isActive,
      };
}
