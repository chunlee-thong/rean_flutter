import 'package:flutter/material.dart';
import 'package:rean_flutter/src/constant/app_theme_color.dart';
import 'package:rean_flutter/src/ui/pages/splash/splash_screen_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rean Flutter',
      theme: ThemeData(
        primarySwatch: AppColor.primaryColor,
      ),
      home: SplashScreenPage(),
    );
  }
}
