import 'package:dinamik_yemek_dagitim/config/route.dart';
import 'package:dinamik_yemek_dagitim/core/themes/theme.dart';
import 'package:dinamik_yemek_dagitim/routing/custom_route.dart';
import 'package:dinamik_yemek_dagitim/view/pages/home_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/view/nfc_card_reader.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
              builder: (BuildContext context) => const MyHomePage());
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => const LoginScreen());
        }
      },
      initialRoute: "MainPage",
    );
  }
}
