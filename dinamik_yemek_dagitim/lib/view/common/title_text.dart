import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const TitleText(
      {super.key,
      this.text,
      this.fontSize = 18,
      this.color = LightColor.titleTextColor,
      this.fontWeight = FontWeight.w800});
  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
