import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class FlutterTabBarViewAnimationExample extends StatefulWidget {
  const FlutterTabBarViewAnimationExample({Key? key}) : super(key: key);

  @override
  _FlutterTabBarViewAnimationExampleState createState() => _FlutterTabBarViewAnimationExampleState();
}

class _FlutterTabBarViewAnimationExampleState extends State<FlutterTabBarViewAnimationExample> with SingleTickerProviderStateMixin {
  late TabController _controller;
  PageController _pageController = PageController();
  double opacity = 1.0;
  int currentPage = 0;

  List<IconData> icons = [
    Icons.car_rental,
    Icons.bike_scooter,
    Icons.shield,
  ];

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();

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
            controller: _controller,
            tabs: [
              Tab(text: "Car"),
              Tab(text: "Bike"),
              Tab(text: "Shield"),
            ],
            isScrollable: true,
            onTap: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            indicator: SmallUnderLineTabIndicator(
              color: Colors.black,
              paddingLeft: 16,
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: _pageController,
              builder: (context, child) {
                return NotificationListener(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      if (notification is ScrollUpdateNotification && !_controller.indexIsChanging) {
                        if ((_pageController.page! - _controller.index).abs() > 1.0) {
                          _controller.index = _pageController.page!.floor();
                        }
                        _controller.offset = (_pageController.page! - _controller.index).clamp(-1.0, 1.0);
                      } else if (notification is ScrollEndNotification) {
                        _controller.index = _pageController.page!.round();
                        if (!_controller.indexIsChanging) _controller.offset = (_pageController.page! - _controller.index).clamp(-1.0, 1.0);
                      }
                    }
                    double data = SuraUtils.degreeToRadian(_pageController.page! * 180);
                    opacity = cos(data).abs();
                    return true;
                  },
                  child: Opacity(
                    opacity: opacity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: icons.length,
                      onPageChanged: (page) {
                        this.currentPage = page;
                      },
                      itemBuilder: (context, index) {
                        if (index == currentPage)
                          return TabChildren(
                            icon: icons[index],
                          );
                        return SizedBox();
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
