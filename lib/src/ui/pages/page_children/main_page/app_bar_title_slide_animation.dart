import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/pages/page_children/widgets/dummy_list_view.dart';

class AppBarTitleSlideAnimationExample extends StatelessWidget {
  const AppBarTitleSlideAnimationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarTitleSlideScaffold(
      title: "PHO SHOP",
      body: Column(
        children: List.generate(
          32,
          (index) => DummyListTile(index: index),
        ),
      ),
    );
  }
}

class AppBarTitleSlideScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  const AppBarTitleSlideScaffold({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  _AppBarTitleSlideScaffoldState createState() => _AppBarTitleSlideScaffoldState();
}

class _AppBarTitleSlideScaffoldState extends State<AppBarTitleSlideScaffold> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late ScrollController scrollController;
  static const double origin = 64.0;
  late ValueNotifier offsetNotifier;

  @override
  void initState() {
    offsetNotifier = ValueNotifier<double>(origin);
    scrollController = ScrollController();
    scrollController.addListener(() {
      //if (scrollController.offset > origin) return;
      offsetNotifier.value = origin - scrollController.offset;
    });
    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    offsetNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: ValueListenableBuilder(
          valueListenable: offsetNotifier,
          child: Text(widget.title),
          builder: (context, dynamic offset, child) {
            double clampOffset = offset.clamp(0.0, origin);
            return Transform.translate(
              child: Opacity(
                child: child,
                opacity: (origin - clampOffset) / origin,
              ),
              offset: Offset(0, clampOffset),
            );
          },
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: widget.body,
      ),
    );
  }
}
