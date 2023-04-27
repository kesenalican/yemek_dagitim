import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => const MainPage(),
      // '/detail': (_) => ProductDetailPage()
    };
  }
}
