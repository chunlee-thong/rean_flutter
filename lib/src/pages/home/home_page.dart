import 'package:flutter/material.dart';
import 'package:rean_flutter/src/model/page_model.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/app_bar_title_slide_animation.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/firebase_crashlytic_example.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/flutter_composite_design_pattern.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/flutter_dynamic_form.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/flutter_font_testing.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/flutter_painter.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/implicit_animation_example.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/pinterest_bottom_navigation_bar.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/scroll_reveal_animation.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/slide_reveal_animation.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/sura_future_manager_example.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/tabbar_view_animation.dart';
import 'package:rean_flutter/src/pages/page_children/main_page/user_guidance_example.dart';
import 'package:rean_flutter/src/provider/theme_provider.dart';
import 'package:rean_flutter/src/ui/widgets/card/page_card_item.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:uni_links/uni_links.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterBuildMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(
        title: "Rean Flutter",
        actions: [
          IconButton(
            onPressed: () => ThemeProvider.getProvider(context).switchTheme(),
            icon: Icon(Icons.switch_account),
          ),
        ],
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        padding: EdgeInsets.all(16),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: PAGE_LIST.map((page) {
          return PageCardItem(page: page);
        }).toList(),
      ),
    );
  }

  @override
  void afterBuild(BuildContext context) async {
    ThemeProvider.getProvider(context).initializeTheme();
    final initialUri = await getInitialUri();
    if (initialUri != null) {
      UIHelper.showToast(initialUri);
    }
    uriLinkStream.listen((Uri? uri) {
      UIHelper.showToast(uri);
    }, onError: (err) {});
  }
}

const List<PageModel> PAGE_LIST = [
  const PageModel(
    page: const AppBarTitleSlideAnimationExample(),
    name: "Appbar title slide animation",
    routeName: "appbar-slide",
  ),
  const PageModel(
    page: const SlideRevealAnimation(),
    name: "Slide Reveal Animation",
    routeName: "slide-reveal-animation",
  ),
  const PageModel(
    page: const PinterestBottomNavigationBarExample(),
    name: "Pinterest Bottom Navigation bar",
    routeName: "pinterest-bottomnavigation",
  ),
  const PageModel(
    page: const SuraFutureManagerExample(),
    name: "Sura FutureManager Example",
    routeName: "sura-futuremanager",
  ),
  const PageModel(
    page: const FlutterCompositePatternWithContentExample(),
    name: "Flutter Composite design pattern",
    routeName: "flutter-composite-design-pattern",
  ),
  const PageModel(
    page: const FlutterFontTesting(),
    name: "Flutter Font testing",
    routeName: "flutter-font-testin",
  ),
  const PageModel(
    page: const ScrollRevealAnimation(),
    name: "Scroll Reveal Animation",
    routeName: "scroll-reveal-animation",
  ),
  const PageModel(
    page: const FirebaseCrashlyticExample(),
    name: "Firebase Crashlytic example",
    routeName: "firebase-craslytic",
  ),
  const PageModel(
    page: const UserGuidanceExample(),
    name: "User Guidance Widget example",
    routeName: "user-guidance-example",
  ),
  const PageModel(
    page: const ImplicitAnimationExample(),
    name: "Implicit animation example",
    routeName: "implicit-animation",
  ),
  const PageModel(
    page: const FlutterTabBarViewAnimationExample(),
    name: "TabBar View Animation",
    routeName: "tabbar-view-animation",
  ),
  const PageModel(
    page: const FlutterDynamicFormExample(),
    name: "Flutter Dynamic Form",
    routeName: "dynamic-form",
  ),
  const PageModel(
    page: const FlutterPainter(),
    name: "Flutter Painter",
    routeName: "flutter-painter",
  ),
];
