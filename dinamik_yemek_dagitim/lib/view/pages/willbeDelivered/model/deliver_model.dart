// To parse this JSON data, do
//
//     final deliver = deliverFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Deliver deliverFromJson(String str) => Deliver.fromJson(json.decode(str));

String deliverToJson(Deliver data) => json.encode(data.toJson());

class Deliver {
  final List<DeliverList> data;
  final bool status;
  final dynamic message;

  Deliver({
    required this.data,
    required this.status,
    required this.message,
  });

  factory Deliver.fromJson(Map<String, dynamic> json) => Deliver(
        data: List<DeliverList>.from(
            json["data"].map((x) => DeliverList.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class DeliverList {
  final String nameOfUser;
  final String consumerName;
  final int userId;
  final int consumerId;
  final DateTime deliveryDate;
  final String coordinate;
  final String id;
  final DateTime createDate;
  final bool isActive;

  DeliverList({
    required this.nameOfUser,
    required this.consumerName,
    required this.userId,
    required this.consumerId,
    required this.deliveryDate,
    required this.coordinate,
    required this.id,
    required this.createDate,
    required this.isActive,
  });

  factory DeliverList.fromJson(Map<String, dynamic> json) => DeliverList(
        nameOfUser: json["nameOfUser"],
        consumerName: json["consumerName"],
        userId: json["userId"],
        consumerId: json["consumerId"],
        deliveryDate: DateTime.parse(json["deliveryDate"]),
        coordinate: json["coordinate"],
        id: json["id"],
        createDate: DateTime.parse(json["createDate"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "nameOfUser": nameOfUser,
        "consumerName": consumerName,
        "userId": userId,
        "consumerId": consumerId,
        "deliveryDate": deliveryDate.toIso8601String(),
        "coordinate": coordinate,
        "id": id,
        "createDate": createDate.toIso8601String(),
        "isActive": isActive,
      };
}
