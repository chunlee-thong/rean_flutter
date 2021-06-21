import 'package:flutter/material.dart';
import 'package:rean_flutter/src/constant/app_theme_color.dart';
import 'package:rean_flutter/src/constant/style_decoration.dart';
import 'package:rean_flutter/src/provider/theme_provider.dart';
import 'package:rean_flutter/src/ui/pages/home/home_page.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future onSplashScreen() async {
    await Future.delayed(Duration(seconds: 2));
    ThemeProvider.getProvider(context).initializeTheme();
    PageNavigator.pushReplacement(context, HomePage());
  }

  @override
  void initState() {
    onSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Text(
          "Rean Flutter",
          style: MTS.h3.white,
        ),
      ),
    );
  }
}
