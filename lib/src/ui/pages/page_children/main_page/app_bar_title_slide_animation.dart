import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rean_flutter/src/ui/pages/page_children/widgets/dummy_list_view.dart';

class AppBarTitleSlideAnimationExample extends StatelessWidget {
  const AppBarTitleSlideAnimationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarTitleSlideScaffold(
      title: Column(
        children: [
          Text("PHO SHOP"),
          Text(
            "since 1980",
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
        ],
      ),
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
  final Widget title;
  final Widget body;
  const AppBarTitleSlideScaffold({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  _AppBarTitleSlideScaffoldState createState() => _AppBarTitleSlideScaffoldState();
}

enum Scroll {
  up,
  down,
}

class _AppBarTitleSlideScaffoldState extends State<AppBarTitleSlideScaffold> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late ScrollController scrollController;
  static const double origin = 64.0;
  late ValueNotifier<double> offsetNotifier;
  Scroll scroll = Scroll.down;

  @override
  void initState() {
    offsetNotifier = ValueNotifier<double>(origin);
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset > origin) return;
      offsetNotifier.value = origin - scrollController.offset;
      if (scrollController.position.userScrollDirection == ScrollDirection.forward) {
        print("Scroll down");
        scroll = Scroll.down;
      } else {
        print("Scroll up");
        scroll = Scroll.up;
      }
    });
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400));
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
        title: ValueListenableBuilder<double>(
          valueListenable: offsetNotifier,
          child: widget.title,
          builder: (context, double offset, child) {
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // if (notification is ScrollEndNotification) {
          //   if (offsetNotifier.value > 0 && offsetNotifier.value < origin) {
          //     if (scroll == Scroll.up) {
          //       offsetNotifier.value = 0;
          //     } else {
          //       offsetNotifier.value = origin;
          //     }
          //   }
          // }
          return true;
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: widget.body,
        ),
      ),
    );
  }
}
