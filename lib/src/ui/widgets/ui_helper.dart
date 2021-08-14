import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIHelper {
  static AppBar CustomAppBar({
    required String title,
    bool centerTitle = true,
    List<Widget>? actions,
  }) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  static void showToast(message) {
    Fluttertoast.showToast(
        msg: "$message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
