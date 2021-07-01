import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/pages/page_children/widgets/dummy_list_view.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class ScrollRevealAnimation extends StatefulWidget {
  const ScrollRevealAnimation({Key? key}) : super(key: key);

  @override
  _ScrollRevealAnimationState createState() => _ScrollRevealAnimationState();
}

class _ScrollRevealAnimationState extends State<ScrollRevealAnimation> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Scroll Reveal Animation"),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            DummyListView(count: 10),
            RevealWrapper(
              scrollController: scrollController,
              child: SizedBox(
                child: Card(
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.handyman_outlined,
                          color: context.primaryColor,
                          size: 32,
                        ),
                        SpaceY(),
                        Text("Welcome to our community"),
                        SpaceX(4),
                        Text("We will bring you the best experience you have ever got!")
                      ],
                    ),
                  ),
                ),
                width: double.infinity,
              ),
            ),
            DummyListView(),
          ],
        ),
      ),
    );
  }
}

class RevealWrapper extends StatelessWidget {
  final ScrollController scrollController;
  final Widget child;
  const RevealWrapper({
    Key? key,
    required this.scrollController,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, _) {
        RenderBox? renderObject = context.findRenderObject() as RenderBox?;
        final offSetY = renderObject?.localToGlobal(Offset.zero).dy ?? 0;

        ///Y offset of this widget relevant to global position
        ///if it's <=0, it's mean we already scroll passed it
        if (offSetY <= 0) {
          return child;
        }

        final deviceHeight = MediaQuery.of(context).size.height;

        ///if heightVisible reach 0, its mean our widget is shown to screen
        final heightVisible = deviceHeight - offSetY;
        final widgetHeight = renderObject?.size.height ?? 0;

        ///how much percentage of it's height that has been show
        final howMuchShown = (heightVisible / widgetHeight).clamp(0.0, 1.0);
        final opacity = 0.25 + howMuchShown * 0.75;

        return Transform.scale(
          scale: opacity,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
    );
  }
}
