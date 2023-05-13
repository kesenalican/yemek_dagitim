import 'package:dinamik_yemek_dagitim/core/themes/light_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showAlertDialog(BuildContext context, String title, String message,
    {String? buttonText, Function? callback}) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(
      buttonText ?? "TAMAM",
      style: const TextStyle(
        color: LightColor.orange,
      ),
    ),
    onPressed: () {
      if (callback != null) {
        callback.call();
      }
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: const TextStyle(
        color: LightColor.orange,
      ),
    ),
    content: Text(
      message,
      style: const TextStyle(
        color: LightColor.orange,
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.white,
    textColor: LightColor.orange,
    fontSize: 20.0,
  );
}

void showProgressDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                return Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    color: LightColor.orange,
                  ),
                );
              },
            ),
          ));
}

void dismissDialog(BuildContext context) {
  Navigator.pop(context);
}
