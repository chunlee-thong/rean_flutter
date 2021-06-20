import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';

class PinterestBottomNavigationBar extends StatefulWidget {
  PinterestBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _PinterestBottomNavigationBarState createState() => _PinterestBottomNavigationBarState();
}

class _PinterestBottomNavigationBarState extends State<PinterestBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Pinterest Bottom Navigation"),
    );
  }
}
