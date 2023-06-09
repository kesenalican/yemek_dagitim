import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/bottomNavigation/bottom_navigation_bar.dart';
import 'package:dinamik_yemek_dagitim/view/common/dialog_utils.dart';
import 'package:dinamik_yemek_dagitim/view/common/title_text.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/nfc/view/nfc_card_reader.dart';
import 'package:dinamik_yemek_dagitim/view/pages/startdaypage/service/start_day_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/startdaypage/view/start_day.dart';
import 'package:dinamik_yemek_dagitim/view/pages/willbeDelivered/view/will_be_delivered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/themes/theme.dart';
import 'homepage/view/home_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key, this.title});

  final String? title;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  //? LOGOUT APPBAR
  bool isHomePageSelected = true;
  bool nfcSelected = false;
  int pageIndex = 0;
  bool isStartDay = true;
  Future<void> queryStartDay() async {
    return await ref.watch(startDayControlProvider.future).then((value) {
      setState(() {
        isStartDay = value;
      });
    });
  }

  Widget _appBar() {
    return Container(
      padding: AppTheme.padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RotatedBox(
            quarterTurns: 4,
            child:
                _icon(Icons.power_settings_new_outlined, color: Colors.black54),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(13)),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff8f8f8),
                      blurRadius: 10,
                      spreadRadius: 10),
                ],
              ),
              child: Image.asset(
                "assets/logo.png",
                height: 70,
                width: 70,
              ),
            ),
          ).ripple(() {},
              borderRadius: const BorderRadius.all(Radius.circular(13)))
        ],
      ),
    );
  }

  Widget _icon(IconData icon, {Color color = LightColor.iconColor}) {
    return Container(
      padding: context.paddingDefault,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        color: Colors.white,
        boxShadow: AppTheme.shadow,
      ),
      child: Icon(
        icon,
        color: color,
      ),
    ).ripple(() async {
      //! LOGOUT
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('expiration');
      prefs.remove('user_name');
      prefs.remove('password');
      prefs.remove('remember_me');
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => route.isFirst);
      }
    }, borderRadius: const BorderRadius.all(Radius.circular(13)));
  }

  Widget _title() {
    return Container(
        margin: AppTheme.padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: isHomePageSelected
                          ? 'Yemek Dağıtım'
                          : 'Yemek Verilmiş',
                      fontSize: 27,
                      fontWeight: FontWeight.w400,
                    ),
                    TitleText(
                      text: isHomePageSelected ? 'Listesi' : 'Kişiler',
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const SaveUser()));
                //     },
                //     icon: const Icon(Icons.add)),
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => const OpenMap()));
                //     },
                //     icon: const Icon(Icons.map)),
              ],
            ),
            const Spacer(),
            !isHomePageSelected
                ? Container(
                    padding: context.paddingDefault,
                    child: const Column(
                      children: [
                        Icon(
                          Icons.stop,
                          color: LightColor.orange,
                        ),
                        Text(
                          'Günü Bitir',
                          style: TextStyle(
                              color: LightColor.orange,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ).ripple(() {
                    ref.watch(endDayProvider.future).then((value) {
                      if (value == true) {
                        showAlertDialog(
                            context, 'Başarılı', 'Gün başarıyla sonlandırıldı');
                        setState(() {});
                      }
                    });
                  }, borderRadius: const BorderRadius.all(Radius.circular(13)))
                : const SizedBox()
          ],
        ));
  }

  void onBottomIconPressed(int index) {
    if (index == 0) {
      setState(() {
        isHomePageSelected = true;
        pageIndex = 0;
      });
    } else if (index == 1) {
      setState(() {
        isHomePageSelected = false;
        pageIndex = 1;
        nfcSelected = true;
      });
    } else {
      setState(() {
        pageIndex = 2;
        isHomePageSelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pageIndex != 1 ? _appBar() : const SizedBox(),
                    pageIndex != 1 ? _title() : const SizedBox(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: pageIndex == 1
                            ? const NfcCardReader()
                            : pageIndex == 0
                                ? const MyHomePage(
                                    title: '',
                                  )
                                : const Align(
                                    alignment: Alignment.topCenter,
                                    child: WillBeDelivered(),
                                  ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
