import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class SlideRevealAnimation extends StatefulWidget {
  const SlideRevealAnimation({Key? key}) : super(key: key);
  @override
  _SlideRevealAnimationState createState() => _SlideRevealAnimationState();
}

class _SlideRevealAnimationState extends State<SlideRevealAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide To Reveal Animation'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Slide this card to the right"),
              SpaceY(16),
              CardSliderAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}

class CardSliderAnimation extends StatefulWidget {
  @override
  _CardSliderAnimationState createState() => _CardSliderAnimationState();
}

class _CardSliderAnimationState extends State<CardSliderAnimation> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> xOffset;
  double delta = 100.0;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    xOffset = Tween<double>(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: AnimatedBuilder(
        animation: xOffset,
        child: BottomCard(),
        builder: (ctx, child) {
          return Stack(
            children: [
              child!,
              Positioned(
                child: GestureDetector(
                  child: TopCard(value: controller.value),
                  onTap: () {
                    if (controller.isCompleted) {
                      controller.reverse();
                    } else {
                      controller.forward();
                    }
                  },
                  onHorizontalDragUpdate: (detail) {
                    controller.value += detail.delta.dx / 50;
                  },
                  onHorizontalDragEnd: (detail) {
                    double velocity = detail.primaryVelocity ?? 0;
                    print(velocity);
                    if (velocity > 0) {
                      controller.fling(velocity: 1);
                    } else if (velocity < 0) {
                      controller.fling(velocity: -1);
                    } else {
                      controller.fling(velocity: controller.value < 0.5 ? -1.0 : 1.0);
                    }
                  },
                ),
                left: xOffset.value,
              )
            ],
          );
        },
      ),
    );
  }
}

class BottomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        type: MaterialType.card,
        color: Colors.deepPurpleAccent.withOpacity(0.2),
        child: Align(
          alignment: Alignment(-0.4, 0.0),
          child: Icon(
            Icons.wallet_giftcard,
            size: 54,
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  final double value;

  const TopCard({Key? key, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        type: MaterialType.card,
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Percentage",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              LinearProgressIndicator(
                value: value,
              ),
              SizedBox(height: 12),
              Text("${(value * 100).toInt()} %", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
