import 'package:flutter/material.dart';

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
}
