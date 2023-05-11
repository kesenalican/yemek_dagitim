import 'package:dinamik_yemek_dagitim/config/route.dart';
import 'package:dinamik_yemek_dagitim/core/themes/theme.dart';
import 'package:dinamik_yemek_dagitim/routing/custom_route.dart';
import 'package:dinamik_yemek_dagitim/view/pages/homepage/view/home_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/view/nfc_card_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  String token = '';
  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token').toString();
  }

  @override
  Widget build(BuildContext context) {
    getToken();
    return MaterialApp(
      title: 'E-Commerce ',
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('verilecek')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) =>
                  token == '' ? const LoginScreen() : const MyHomePage());
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) =>
                  token == '' ? const LoginScreen() : const MyHomePage());
        }
      },
      initialRoute: "MainPage",
    );
  }
}
