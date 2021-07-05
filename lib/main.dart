import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rean_flutter/src/constant/app_theme_color.dart';
import 'package:rean_flutter/src/model/page_model.dart';
import 'package:rean_flutter/src/provider/theme_provider.dart';
import 'package:rean_flutter/src/services/local_storage.service.dart';
import 'package:rean_flutter/src/ui/pages/home/home_page.dart';
import 'package:rean_flutter/src/ui/pages/page_children/main_page/not_found_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.initialize();
  if (!kIsWeb) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: SimpleLocationBuilder(
      routes: {
        // Return either Widgets or BeamPages if more customization is needed
        '/': (context, state) {
          return BeamPage(
            key: ValueKey("home"),
            title: "Home",
            child: HomePage(),
          );
        },
        '/page/:page_name': (context, state) {
          final pageRoute = state.pathParameters['page_name']!;
          PageModel? page = PAGE_LIST.firstWhere(
            (element) => element.routeName == pageRoute,
            orElse: () => PageModel(
              page: NotFoundPage(),
              name: "Not found",
              routeName: "",
            ),
          );
          return BeamPage(
            key: ValueKey(pageRoute),
            title: page.name,
            popToNamed: "/",
            child: page.page,
          );
        }
      },
    ),
    notFoundPage: BeamPage(
      key: ValueKey("not-found"),
      title: "Page not Found",
      popToNamed: "/",
      child: NotFoundPage(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) => Consumer<ThemeProvider>(
          builder: (context, theme, child) => MaterialApp.router(
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
            routeInformationParser: BeamerParser(),
            routerDelegate: routerDelegate,
          ),
        ),
      ),
    );
  }
}
