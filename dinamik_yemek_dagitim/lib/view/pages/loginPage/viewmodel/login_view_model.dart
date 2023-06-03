import 'package:dinamik_yemek_dagitim/view/pages/loginPage/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginViewModel extends ChangeNotifier {
  LoginModel? loginModel;
  String? token;
  bool isActive = false;
  String? expirationDate;
  String? isReadBarcode;
  setUserInfo(LoginModel loginInfo) {
    loginModel = loginInfo;
    notifyListeners();
  }
}

final loginViewModel = ChangeNotifierProvider((ref) => LoginViewModel());
