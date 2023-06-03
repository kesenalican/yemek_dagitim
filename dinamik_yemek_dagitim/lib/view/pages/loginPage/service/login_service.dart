import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/service/base_provider.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/viewmodel/login_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = FutureProvider.autoDispose((ref) async {
  final dio = ref.watch(httpClientProvider);
  final viewModel = ref.watch(loginViewModel);
  String token;
  String expiration;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var formData = viewModel.loginModel;
  final result = await dio.post(
    'User/Login',
    data: formData!.toJson(),
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );
  if (result.statusCode == 200) {
    if (result.data['status'] == true) {
      token = result.data['data']['token'];
      expiration = result.data['data']['expiration'];
      prefs.setString('token', token);
      prefs.setString('expiration', expiration);
      viewModel.token = token;
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      viewModel.isReadBarcode =
          decodedToken['http://userswithoutidentity/claims/readBarcode'];
      viewModel.isActive = true;
      viewModel.expirationDate = expiration;
      return result.data['status'];
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
      return result.data['status'];
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
    return result.data['status'];
  }
});

final isUserActiveProvider = FutureProvider.autoDispose((ref) async {
  final dio = ref.watch(httpClientProvider);
  final viewModel = ref.watch(loginViewModel);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userName = prefs.getString('user_name');

  final result = await dio.get(
    'User/GetUserStatusByUserName',
    queryParameters: {'userName': userName},
    options: Options(
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
    ),
  );
  if (result.statusCode == 200) {
    viewModel.isActive = true;
    return true;
  } else {
    viewModel.isActive = false;
    prefs.remove('user_name');
    prefs.remove('token');
    prefs.remove('expiration');
    prefs.remove('password');
    prefs.remove('remember_me');
    return false;
  }
});
