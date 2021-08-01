import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class FlutterTabBarViewAnimationExample extends StatefulWidget {
  const FlutterTabBarViewAnimationExample({Key? key}) : super(key: key);

  @override
  _FlutterTabBarViewAnimationExampleState createState() => _FlutterTabBarViewAnimationExampleState();
}

class _FlutterTabBarViewAnimationExampleState extends State<FlutterTabBarViewAnimationExample> with SingleTickerProviderStateMixin {
  late TabController tabController;
  PageController pageController = PageController();
  double opacity = 1.0;
  int currentPage = 0;

  List<IconData> icons = [
    Icons.car_rental,
    Icons.bike_scooter,
    Icons.shield,
  ];

  @override
  void initState() {
    tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TabBar View Animation"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(text: "Car"),
              Tab(text: "Bike"),
              Tab(text: "Shield"),
            ],
            isScrollable: true,
            indicator: SmallUnderLineTabIndicator(
              color: Colors.black,
              paddingLeft: 16,
            ),
          ),
          Expanded(
            child: AnimatedTabBarView(
              children: icons.map((e) => TabChildren(icon: e)).toList(),
              tabController: tabController,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedTabBarView extends StatefulWidget {
  final TabController tabController;
  final List<Widget> children;
  const AnimatedTabBarView({
    Key? key,
    required this.tabController,
    required this.children,
  }) : super(key: key);

  @override
  _AnimatedTabBarViewState createState() => _AnimatedTabBarViewState();
}

class _AnimatedTabBarViewState extends State<AnimatedTabBarView> {
  double opacity = 1.0;
  int currentPage = 0;

  void tabBarListener() {
    pageController.animateToPage(
      widget.tabController.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  late final PageController pageController;

  @override
  void initState() {
    currentPage = widget.tabController.index;
    pageController = PageController(initialPage: currentPage);
    widget.tabController.addListener(tabBarListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.tabController.removeListener(tabBarListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      child: PageView.builder(
        controller: pageController,
        itemCount: widget.children.length,
        onPageChanged: (page) {
          ///This function called after you scroll pass 70% of current page
          ///So after this function called, our current page is already a new page
          ///but current itemBuilder index is still an old page
          ///so it cause itemBuilder to render SizedBox until we finished
          setState(() {
            this.currentPage = page;
          });
        },
        itemBuilder: (context, index) {
          print("rebuild builder");
          if (index == currentPage) return widget.children[index];
          return const SizedBox();
        },
      ),
      builder: (context, child) {
        return NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              if (notification is ScrollUpdateNotification && !widget.tabController.indexIsChanging) {
                if ((pageController.page! - widget.tabController.index).abs() > 1.0) {
                  widget.tabController.index = pageController.page!.floor();
                }
                widget.tabController.offset = (pageController.page! - widget.tabController.index).clamp(-1.0, 1.0);
              } else if (notification is ScrollEndNotification) {
                widget.tabController.index = pageController.page!.round();
                if (!widget.tabController.indexIsChanging)
                  widget.tabController.offset = (pageController.page! - widget.tabController.index).clamp(-1.0, 1.0);
              }
            }
            double currentPageInRadian = SuraUtils.degreeToRadian(pageController.page! * 180);
            opacity = cos(currentPageInRadian).abs();
            return true;
          },
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
    );
  }
}

class TabChildren extends StatelessWidget {
  final IconData icon;
  const TabChildren({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0.0, 0.0),
            blurRadius: 10,
            spreadRadius: 5,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 200,
        color: Colors.blue,
      ),
    );
  }
}
