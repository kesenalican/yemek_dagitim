import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
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
    home: const MyFirstPage(),
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
    var token = prefs.getString('token');
    var expiration = prefs.getString('expiration');
    var userName = prefs.getString('user_name');
    if (token == null) {
      isUserActive = false;
      isLoading = false;
      firstOpen = true;
      prefs.remove('user_name');
      prefs.remove('token');
      prefs.remove('expiration');
      prefs.remove('password');
      prefs.remove('remember_me');
      return Future<bool>.value(false);
    } else {
      if (expiration != null &&
          (DateTime.parse(expiration.toString()).millisecondsSinceEpoch <=
              DateTime.now().millisecondsSinceEpoch)) {
        prefs.getString('token') == null;
        prefs.getString('expiration') == null;
        isUserActive = false;
        isLoading = false;
        firstOpen = true;
        return Future<bool>.value(false);
      } else {
        if (userName != null) {
          return await ref.watch(isUserActiveProvider.future).then((value) {
            if (value == true) {
              isUserActive = true;
              isLoading = false;
              firstOpen = false;
              return Future<bool>.value(true);
            } else {
              isUserActive = false;
              isLoading = false;
              firstOpen = true;
              return Future<bool>.value(false);
            }
          });
        } else {
          return Future<bool>.value(false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: queryUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
          return const SizedBox();
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

