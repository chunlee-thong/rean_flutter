import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class ImplicitAnimationExample extends StatefulWidget {
  const ImplicitAnimationExample({Key? key}) : super(key: key);

  @override
  _ImplicitAnimationExampleState createState() => _ImplicitAnimationExampleState();
}

class _ImplicitAnimationExampleState extends State<ImplicitAnimationExample> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Implicit Animation example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.lightBlue,
                    child: Text("TweenAnimationBuilder: $value"),
                  ),
                );
              },
            ),
            SpaceY(16),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, value) {
                return ScaleTransition(scale: value, child: child);
              },
              child: Container(
                key: ValueKey<int>(count),
                padding: EdgeInsets.all(16),
                color: Colors.lightBlue,
                child: Text(
                  "Animated Switcher: $count",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            count += 1;
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
