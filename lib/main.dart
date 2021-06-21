import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rean_flutter/src/constant/app_theme_color.dart';
import 'package:rean_flutter/src/provider/theme_provider.dart';
import 'package:rean_flutter/src/services/local_storage.service.dart';
import 'package:rean_flutter/src/ui/pages/splash/splash_screen_page.dart';

void main() async {
  await LocalStorage.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) => Consumer<ThemeProvider>(
          builder: (context, theme, child) => MaterialApp(
            title: 'Rean Flutter',
            theme: theme.isDarkTheme
                ? ThemeData(
                    primarySwatch: AppColor.primaryColor,
                    brightness: Brightness.dark,
                  )
                : ThemeData(
                    primarySwatch: AppColor.primaryColor,
                  ),
            debugShowCheckedModeBanner: false,
            home: SplashScreenPage(),
          ),
        ),
      ),
    );
  }
}
