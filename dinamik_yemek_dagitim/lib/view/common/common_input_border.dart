import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:flutter/material.dart';

class CommonInputBorder extends StatelessWidget {
  final String labelText;
  final IconData icon;
  const CommonInputBorder({
    super.key,
    required this.labelText,
    required this.icon,
  });

  CommonInputBorder copyWith({
    String? labelText,
    IconData? icon,
  }) {
    return CommonInputBorder(
      labelText: labelText ?? this.labelText,
      icon: icon ?? this.icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      cursorColor: LightColor.darkgrey,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: LightColor.darkgrey,
        ),
        prefixIcon: Icon(
          icon,
          color: LightColor.darkgrey,
        ),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  static final errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
    ),
  );

  static final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: LightColor.darkgrey,
    ),
  );

  static final borderIp = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.white,
    ),
  );
}
