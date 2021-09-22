import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';

class FlutterPainter extends StatefulWidget {
  const FlutterPainter({Key? key}) : super(key: key);
  @override
  _FlutterPainterState createState() => _FlutterPainterState();
}

class _FlutterPainterState extends State<FlutterPainter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Flutter Painter"),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: CustomPaint(
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()..color = Colors.blue;
    //circle
    canvas.drawCircle(Offset(34, 34), 32, bluePaint);
    //shadow
    final path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);
    canvas.drawShadow(path, Colors.grey.withOpacity(0.4), 2, false);
    //
    canvas.drawArc(
      Rect.fromLTWH(80, 32.0, 32, 32),
      0,
      pi * 2,
      false,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
