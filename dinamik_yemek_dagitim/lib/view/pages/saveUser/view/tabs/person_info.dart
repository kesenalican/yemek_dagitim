//! ADRES - İSİM - TC

import 'package:dinamik_yemek_dagitim/view/common/common_text_field.dart';
import 'package:dinamik_yemek_dagitim/view/pages/loginPage/view/login_button.dart';
import 'package:flutter/material.dart';

class PersonInfo extends StatefulWidget {
  const PersonInfo({super.key});

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController tcController;
  late TextEditingController adresController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    tcController = TextEditingController();
    adresController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    tcController.dispose();
    adresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            CommonTextField(
              validator: (value) {
                if (value!.isEmpty || value.length < 3) {
                  return 'İsim kısmı boş olamaz!';
                }
                return null;
              },
              controller: nameController,
              field: 'İsim - Soyisim',
              icon: Icons.person,
              isMandatory: true,
              readOnly: false,
              textInputType: TextInputType.name,
            ),
            CommonTextField(
              validator: (value) {
                if (value!.length <= 11) {
                  return 'Geçerli bir T.C kimlik numarası giriniz!';
                }
                return null;
              },
              controller: tcController,
              field: 'T.C',
              icon: Icons.credit_card,
              isMandatory: true,
              readOnly: false,
              textInputType: TextInputType.number,
            ),
            CommonTextField(
              validator: (value) {
                if (value!.length <= 10) {
                  return 'Geçerli bir adres giriniz!';
                }
                return null;
              },
              controller: tcController,
              field: 'Adres',
              icon: Icons.home,
              isMandatory: true,
              readOnly: false,
              textInputType: TextInputType.streetAddress,
              isAddress: true,
            ),
            GetStartedButton(
                name: 'Kayıt Et', onTap: () {}, elementsOpacity: 1.0),
          ],
        ),
      ),
    );
  }
}
