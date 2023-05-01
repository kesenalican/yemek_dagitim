import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:dinamik_yemek_dagitim/extensions/extensions.dart';
import 'package:dinamik_yemek_dagitim/view/common/common_input_border.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? field;
  final IconData? icon;
  final TextInputType? textInputType;
  final bool? isMandatory;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final void Function(String?)? onSaved;
  final bool isAddress;

  const CommonTextField({
    Key? key,
    this.controller,
    this.field,
    this.icon,
    this.textInputType,
    this.readOnly,
    required this.validator,
    this.isMandatory,
    this.onSaved,
    this.isAddress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidth * 0.02,
          vertical: context.dynamicHeight * 0.007,
        ),
        child: TextFormField(
          validator: validator,
          textInputAction: TextInputAction.next,
          readOnly: readOnly ?? false,
          // onChanged: onChanged,
          maxLines: isAddress ? 4 : 1,
          onSaved: onSaved,
          controller: controller,
          keyboardType: textInputType,
          cursorColor: LightColor.darkgrey,
          style: const TextStyle(
            color: LightColor.darkgrey,
          ),
          decoration: InputDecoration(
            labelText: field,
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: LightColor.darkgrey,
            ),
            prefixIcon: Icon(
              icon,
              color: LightColor.darkgrey,
            ),
            errorBorder: CommonInputBorder.errorBorder,
            enabledBorder: CommonInputBorder.border,
            focusedBorder: CommonInputBorder.border,
          ),
        ));
  }
}

class CommonTextFieldIp extends StatelessWidget {
  final TextEditingController? controller;
  final String? field;
  final IconData? icon;
  final TextInputType? textInputType;
  final bool? isMandatory;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final void Function(String?)? onSaved;

  const CommonTextFieldIp({
    Key? key,
    this.controller,
    this.field,
    this.icon,
    this.textInputType,
    this.readOnly,
    required this.validator,
    this.isMandatory,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.dynamicWidth * 0.02,
          vertical: context.dynamicHeight * 0.01,
        ),
        child: TextFormField(
          validator: validator,
          textInputAction: TextInputAction.next,
          readOnly: readOnly ?? false,
          // onChanged: onChanged,
          onSaved: onSaved,
          controller: controller,
          keyboardType: textInputType,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: field,
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            errorBorder: CommonInputBorder.errorBorder,
            enabledBorder: CommonInputBorder.borderIp,
            focusedBorder: CommonInputBorder.borderIp,
          ),
        ));
  }
}
