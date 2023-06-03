// To parse this JSON data, do
//
//     final nfcModel = nfcModelFromJson(jsonString);

import 'dart:convert';

NfcModel nfcModelFromJson(String str) => NfcModel.fromJson(json.decode(str));

String nfcModelToJson(NfcModel data) => json.encode(data.toJson());

class NfcModel {
  final String id;
  final String cardNumber;
  final String coordinate;
  final bool readBarcode;

  NfcModel({
    this.id = '00000000-0000-0000-0000-000000000000',
    required this.cardNumber,
    required this.coordinate,
    required this.readBarcode,
  });

  factory NfcModel.fromJson(Map<String, dynamic> json) => NfcModel(
      id: '00000000-0000-0000-0000-000000000000',
      cardNumber: json["cardNumber"],
      coordinate: json["coordinate"],
      readBarcode: json["readBarcode"]);

  Map<String, dynamic> toJson() => {
        "id": '00000000-0000-0000-0000-000000000000',
        "cardNumber": cardNumber,
        "coordinate": coordinate,
        "readBarcode": readBarcode,
      };
}
