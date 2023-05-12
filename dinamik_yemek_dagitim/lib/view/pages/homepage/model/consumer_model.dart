// To parse this JSON data, do
//
//     final consumerModel = consumerModelFromJson(jsonString);

import 'dart:convert';

ConsumerModel consumerModelFromJson(String str) =>
    ConsumerModel.fromJson(json.decode(str));

String consumerModelToJson(ConsumerModel data) => json.encode(data.toJson());

class ConsumerModel {
  final List<ConsumerListModel> data;
  final bool status;
  final dynamic message;

  ConsumerModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory ConsumerModel.fromJson(Map<String, dynamic> json) => ConsumerModel(
        data: List<ConsumerListModel>.from(
            json["data"].map((x) => ConsumerListModel.fromJson(x))),
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
  final String cityName;
  final String countyName;
  final String neighborhoodName;
  final String identityNumber;
  final String name;
  final String phone;
  final int cityId;
  final int countyId;
  final int neighborhoodId;
  final String street;
  final String buildNo;
  final String doorNo;
  final String detail;
  final dynamic coordinate;
  final int id;
  final DateTime createDate;
  final bool isActive;

  ConsumerListModel({
    required this.cityName,
    required this.countyName,
    required this.neighborhoodName,
    required this.identityNumber,
    required this.name,
    required this.phone,
    required this.cityId,
    required this.countyId,
    required this.neighborhoodId,
    required this.street,
    required this.buildNo,
    required this.doorNo,
    required this.detail,
    required this.coordinate,
    required this.id,
    required this.createDate,
    required this.isActive,
  });

  factory ConsumerListModel.fromJson(Map<String, dynamic> json) =>
      ConsumerListModel(
        cityName: json["cityName"],
        countyName: json["countyName"],
        neighborhoodName: json["neighborhoodName"],
        identityNumber: json["identityNumber"],
        name: json["name"],
        phone: json["phone"],
        cityId: json["cityId"],
        countyId: json["countyId"],
        neighborhoodId: json["neighborhoodId"],
        street: json["street"],
        buildNo: json["buildNo"],
        doorNo: json["doorNo"],
        detail: json["detail"] ?? '',
        coordinate: json["coordinate"],
        id: json["id"],
        createDate: DateTime.parse(json["createDate"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "cityName": cityName,
        "countyName": countyName,
        "neighborhoodName": neighborhoodName,
        "identityNumber": identityNumber,
        "name": name,
        "phone": phone,
        "cityId": cityId,
        "countyId": countyId,
        "neighborhoodId": neighborhoodId,
        "street": street,
        "buildNo": buildNo,
        "doorNo": doorNo,
        "detail": detail,
        "coordinate": coordinate,
        "id": id,
        "createDate": createDate.toIso8601String(),
        "isActive": isActive,
      };
}
