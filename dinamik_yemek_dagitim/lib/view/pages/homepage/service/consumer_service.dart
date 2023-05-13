import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/service/base_provider.dart';
import 'package:dinamik_yemek_dagitim/view/pages/homepage/model/consumer_model.dart';
import 'package:dinamik_yemek_dagitim/view/pages/homepage/viewmodel/consumer_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getConsumer = FutureProvider.autoDispose((ref) async {
  final dio = ref.watch(httpClientProvider);
  final viewModel = ref.watch(consumerViewModel);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  final result = await dio.get('Consumer/GetListConsumer',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ));
  if (result.statusCode == 200) {
    List<Map<String, dynamic>> mapData = List.from(result.data['data']);
    List<ConsumerListModel> consumerList =
        mapData.map((e) => ConsumerListModel.fromJson(e)).toList();
    viewModel.consumerList = consumerList;
    return consumerList;
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
