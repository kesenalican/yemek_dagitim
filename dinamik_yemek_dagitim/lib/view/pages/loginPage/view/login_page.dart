import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/view/common/dialog_utils.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/model/login_model.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/service/login_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/email_field.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_button.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/password_field.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/viewmodel/login_view_model.dart';
import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/startdaypage/service/start_day_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/startdaypage/view/start_day.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool rememberMe = false;
  double _elementsOpacity = 1;
  bool loadingBallAppear = false;
  double loadingBallSize = 1;
  bool isStartDay = false;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    loadLoginInfo();
    super.initState();
  }

  Future<void> queryStartDay() async {
    return await ref.watch(startDayControlProvider.future).then((value) {
      setState(() {
        isStartDay = value;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loadLoginInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userName = prefs.getString('user_name');
      var password = prefs.getString('password');
      rememberMe = prefs.getBool('remember_me')!;
      setState(() {
        rememberMe = true;
        emailController.text = userName!;
        passwordController.text = password!;
      });
      if (userName!.isEmpty || password!.isEmpty) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            return showToast('Uygulamaya Hoşgeldiniz');
          },
        );
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    queryStartDay();
    var loginModel = ref.watch(loginViewModel);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 300),
                    tween: Tween(begin: 1, end: _elementsOpacity),
                    builder: (_, value, __) => Opacity(
                      opacity: value,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.food_bank,
                              size: 60, color: LightColor.orange),
                          SizedBox(height: 25),
                          Text(
                            "Dinamik Yemek Dağıtım",
                            style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        EmailField(
                            fadeEmail: _elementsOpacity == 0,
                            emailController: emailController),
                        const SizedBox(height: 40),
                        PasswordField(
                            fadePassword: _elementsOpacity == 0,
                            passwordController: passwordController),
                        const SizedBox(height: 20),
                        CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: LightColor.orange,
                          value: rememberMe,
                          onChanged: buildRememberMeShared,
                          title: const Text(
                            'Beni Hatırla',
                            style: TextStyle(color: Colors.black),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        GetStartedButton(
                          name: 'Giriş Yap',
                          elementsOpacity: _elementsOpacity,
                          onTap: () {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            loginModel.setUserInfo(LoginModel(
                                userName: emailController.text,
                                password: passwordController.text));
                            showProgressDialog(context);
                            ref.watch(authProvider.future).then((value) {
                              dismissDialog(context);
                              if (value == true) {
                                setState(() {
                                  _elementsOpacity = 0;
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => !isStartDay
                                            ? const StartDay()
                                            : const MainPage()),
                                    (route) => false);
                              }
                            });
                          },
                          onAnimatinoEnd: () async {
                            if (loginModel.isActive == true) {
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                // setState(() {
                                //   loadingBallAppear = true;
                                // });
                                loadingBallAppear = true;
                              });
                            } else {}
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void buildRememberMeShared(bool? value) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setString('user_name', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setBool('remember_me', value!);
    });
    setState(() {
      rememberMe = value!;
    });
  }
}
