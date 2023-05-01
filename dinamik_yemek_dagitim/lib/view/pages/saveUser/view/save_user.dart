import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/view/pages/saveUser/view/tabs/person_info.dart';
import 'package:dinamik_yemek_dagitim/view/pages/saveUser/view/tabs/person_location.dart';
import 'package:dinamik_yemek_dagitim/view/pages/saveUser/view/tabs/person_nfc_match.dart';
import 'package:flutter/material.dart';

class SaveUser extends StatelessWidget {
  const SaveUser({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Kişi Kayıt',
              style: TextStyle(
                color: LightColor.darkgrey,
              ),
            ),
            iconTheme: const IconThemeData(
              color: LightColor.darkgrey,
            ),
            backgroundColor: LightColor.background,
            elevation: 0,
            bottom: const TabBar(indicatorColor: LightColor.darkgrey, tabs: [
              Tab(
                icon: Icon(Icons.info),
              ),
              Tab(
                icon: Icon(Icons.location_on_outlined),
              ),
              Tab(
                icon: Icon(Icons.document_scanner_outlined),
              ),
            ]),
          ),
          body: const TabBarView(
            children: [
              PersonInfo(),
              PersonLocation(),
              PersonNfcMatch(),
            ],
          ),
        ));
  }
}
