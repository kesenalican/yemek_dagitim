import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/view/common/dialog_utils.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/service/login_service.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_page.dart';
import 'package:dinamik_yemek_dagitim/view/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(ProviderScope(
      child: MaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [],
    theme: ThemeData.light().copyWith(
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: LightColor.orange,
      ),
    ),
    title: 'Dinamik Yemek Dağıtım',
    home: const LoginScreen(),
  )));
}

class MyFirstPage extends ConsumerStatefulWidget {
  const MyFirstPage({super.key});

  @override
  ConsumerState<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends ConsumerState<MyFirstPage> {
  bool isLoading = false;
  bool isUserActive = false;
  bool firstOpen = false;
  Future<bool> queryUser() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    var expiration = prefs.getString('expiration');
    if (token.isEmpty) {
      isUserActive = false;
      isLoading = false;
      firstOpen = true;
      setState(() {});
      return Future<bool>.value(false);
    } else {
      if (DateTime.parse(expiration.toString()).day == DateTime.now().day) {
        prefs.getString('token') == null;
        prefs.getString('expiration') == null;
        isUserActive = false;
        isLoading = false;
        firstOpen = true;
        return Future<bool>.value(false);
      } else {
        isUserActive = true;
        isLoading = false;
        firstOpen = false;
        setState(() {});
        return Future<bool>.value(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    queryUser().then((value) {
      if (value == true) {
        isUserActive = true;
      } else {
        isUserActive = false;
        ref.watch(authProvider.future).then((value) {
          if (value == true) {
            isUserActive = true;
            return;
          } else {
            firstOpen = true;
            isUserActive = false;
            showAlertDialog(
              context,
              'Kullanıcı Girişi Hatası',
              'Lütfen yeniden giriş yapınız',
            );
          }
        });
      }
    });
    return FutureBuilder(
      future: queryUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('user aktifmi ? $isUserActive');
          return isLoading
              ? const Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                    color: LightColor.orange,
                  )),
                )
              : isUserActive
                  ? const MainPage()
                  : const LoginScreen();
        } else {
          return showAlertDialog(context, 'Servis Hatası',
              'Lütfen internet bağlantınızın olduğundan emin veya uygulama yetkilisi ile iletişime geçin');
        }
      },
    );
  }
}




// class MyApp extends StatelessWidget {
//   MyApp({super.key, this.token = ''});
//   String token;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'E-Commerce ',
//       theme: AppTheme.lightTheme.copyWith(
//         textTheme: GoogleFonts.mulishTextTheme(
//           Theme.of(context).textTheme,
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       routes: Routes.getRoute(),
//       onGenerateRoute: (RouteSettings settings) {
//         if (settings.name!.contains('MainPage')) {
//           return CustomRoute<bool>(
//               builder: (BuildContext context) =>
//                   token == '' ? const LoginScreen() : const MyHomePage());
//         } else {
//           return CustomRoute<bool>(
//               builder: (BuildContext context) =>
//                   token == '' ? const LoginScreen() : const MyHomePage());
//         }
//       },
//       initialRoute: "MainPage",
//     );
//   }
// }

