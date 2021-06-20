import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';

class AppBarTitleSlideAnimation extends StatefulWidget {
  const AppBarTitleSlideAnimation({Key? key}) : super(key: key);

  @override
  _AppBarTitleSlideAnimationState createState() => _AppBarTitleSlideAnimationState();
}

class _AppBarTitleSlideAnimationState extends State<AppBarTitleSlideAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "AppBar Title Slide Animation"),
    );
  }
}
