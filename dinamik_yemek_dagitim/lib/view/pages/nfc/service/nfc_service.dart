import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/service/base_provider.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/model/nfc_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final nfcReader =
    FutureProvider.family.autoDispose<bool, NfcModel>((ref, nfcModel) async {
  final dio = ref.watch(httpClientProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  var formData = NfcModel(
      id: nfcModel.id,
      cardNumber: nfcModel.cardNumber,
      coordinate: nfcModel.coordinate);

  final result = await dio.post(
    'Delivery/AddFoodMovement',
    data: formData.toJson(),
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {'Authorization': 'Bearer $token'},
    ),
  );

  if (result.statusCode == 200) {
    if (result.data['status'] == true) {
      Fluttertoast.showToast(
        msg: '${result.data['message']}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: LightColor.orange,
        fontSize: 14,
      );
      return true;
    } else {
      Fluttertoast.showToast(
        msg: '${result.data['message']}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: LightColor.orange,
        fontSize: 14,
      );
      return false;
    }
  } else {
    Fluttertoast.showToast(
      msg: '${result.data['message']}',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: LightColor.orange,
      fontSize: 14,
    );
    return false;
  }
});
