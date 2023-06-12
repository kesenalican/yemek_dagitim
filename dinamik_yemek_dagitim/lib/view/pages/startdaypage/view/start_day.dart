import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_button.dart';
import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/startdaypage/service/start_day_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartDay extends ConsumerStatefulWidget {
  const StartDay({super.key});

  @override
  ConsumerState<StartDay> createState() => _StartDayState();
}

void setShared() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('start_day', true);
}

class _StartDayState extends ConsumerState<StartDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetStartedButton(
          onTap: () {
            startDay();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
                (route) => false);
          },
          elementsOpacity: 1,
          name: 'Günü Başlat',
          onAnimatinoEnd: () {},
        ),
      ),
    );
  }
 
  Future<bool> startDay() async {
    return await ref.watch(startDayProvider.future).then((value) {
      if (value == true) {
        setShared();
        return true;
      } else {
        return false;
      }
    });
  }
}
