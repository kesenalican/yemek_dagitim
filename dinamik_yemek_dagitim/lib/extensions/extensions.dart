import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get dynamicHeight => MediaQuery.of(this).size.height;
  double get dynamicWidth => MediaQuery.of(this).size.width;
  ThemeData get theme => Theme.of(this);
}

extension PaddindExtension on BuildContext {
  EdgeInsets get paddingDefault => EdgeInsets.all(dynamicHeight * 0.01);
  EdgeInsets get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: dynamicWidth * 0.1);
  EdgeInsets get paddingTextField => EdgeInsets.symmetric(
      horizontal: dynamicWidth * 0.07, vertical: dynamicHeight * 0.01);
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension OnPressed on Widget {
  Widget ripple(Function onPressed,
          {BorderRadiusGeometry borderRadius =
              const BorderRadius.all(Radius.circular(5))}) =>
      Stack(
        children: <Widget>[
          this,
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(borderRadius: borderRadius),
                )),
                onPressed: () {
                  onPressed();
                },
                child: Container()),
          )
        ],
      );
}
