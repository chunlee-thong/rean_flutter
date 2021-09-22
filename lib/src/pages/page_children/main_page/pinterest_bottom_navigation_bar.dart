import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rean_flutter/src/pages/page_children/widgets/dummy_list_view.dart';
import 'package:rean_flutter/src/ui/widgets/center_text.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class PinterestBottomNavigationBarExample extends StatefulWidget {
  const PinterestBottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  _PinterestBottomNavigationBarExampleState createState() => _PinterestBottomNavigationBarExampleState();
}

class _PinterestBottomNavigationBarExampleState extends State<PinterestBottomNavigationBarExample> {
  //
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Pinterest Bottom Navigation"),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          DummyTileListView(scrollController: scrollController),
          DummyImageListView(),
          CenterText("Page 3"),
          CenterText("Page 4"),
        ],
      ),
      floatingActionButton: PinterestBottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          Icon(Icons.home),
          Icon(Icons.image),
          Icon(Icons.message),
          CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage(SuraUtils.unsplashImage(category: "avatar")),
          ),
        ],
        scrollController: scrollController,
        onTap: (index) {
          pageController.jumpToPage(index);
          currentIndex = index;
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class PinterestBottomNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final int currentIndex;
  final ScrollController scrollController;
  final void Function(int)? onTap;
  const PinterestBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    required this.scrollController,
  }) : super(key: key);

  @override
  _PinterestBottomNavigationBarState createState() => _PinterestBottomNavigationBarState();
}

class _PinterestBottomNavigationBarState extends State<PinterestBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  //
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 300),
  );

  late Animation<Offset> offset;

  @override
  void initState() {
    offset = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 2),
    ).animate(controller);

    widget.scrollController.addListener(() {
      if (controller.isAnimating) return;
      if (widget.scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (controller.isCompleted) controller.reverse();
      } else {
        if (!controller.isCompleted) controller.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Card(
        shape: StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.items.length, (index) {
                bool selected = index == widget.currentIndex;
                Widget child;
                if (widget.items[index] is Icon) {
                  Icon icon = widget.items[index] as Icon;
                  child = Icon(
                    icon.icon,
                    color: selected ? Colors.black : Colors.grey,
                  );
                } else {
                  child = widget.items[index];
                }
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      widget.onTap?.call(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      child: child,
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
