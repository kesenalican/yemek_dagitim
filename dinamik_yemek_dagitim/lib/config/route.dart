import 'package:dinamik_yemek_dagitim/view/pages/home_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/view/nfc_card_reader.dart';
import 'package:dinamik_yemek_dagitim/view/pages/will_be_delivered.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => const MainPage(),
      '/verilecek': (_) => const MyHomePage(),
      '/verilen': (_) => const WillBeDelivered(),
      '/nfc': (_) => const NfcCardReader(),
    };
  }
}
