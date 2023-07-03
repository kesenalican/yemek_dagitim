import 'package:dinamik_yemek_dagitim/service/base_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final startDayProvider = FutureProvider((ref) async {
  final dio = ref.watch(httpClientProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  print(token);
  final result = await dio.post(
    'Delivery/StartDelivery',
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {'Authorization': 'Bearer $token'},
    ),
  );
  if (result.statusCode == 200) {
    if (result.data['status'] == false) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
});

final endDayProvider = FutureProvider((ref) async {
  final dio = ref.watch(httpClientProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  print(token);
  final result = await dio.post(
    'Delivery/EndDelivery',
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {'Authorization': 'Bearer $token'},
    ),
  );
  if (result.statusCode == 200) {
    if (result.data['status'] == false) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
});

final startDayControlProvider = FutureProvider((ref) async {
  final dio = ref.watch(httpClientProvider);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  final result = await dio.get(
    'Delivery/IsStartDelivery',
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {'Authorization': 'Bearer $token'},
    ),
  );
  if (result.statusCode == 200) {
    return false;
  } else {
    return false;
  }
});
