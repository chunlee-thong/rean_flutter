import 'package:flutter/material.dart';
import 'package:rean_flutter/src/model/page_model.dart';
import 'package:rean_flutter/src/ui/pages/page_children/app_bar_title_slide_animation.dart';
import 'package:rean_flutter/src/ui/pages/page_children/slide_reveal.dart';
import 'package:rean_flutter/src/ui/widgets/card/page_card_item.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Rean Flutter"),
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
}

const List<PageModel> PAGE_LIST = [
  const PageModel(
    page: const AppBarTitleSlideAnimation(),
    name: "Appbar title slide animation",
  ),
  const PageModel(
    page: const SlideRevealAnimation(),
    name: "Slide Reveal Animation",
  ),
];
