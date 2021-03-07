import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:trotter/trotter.dart';

import 'dot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimationScreen(),
    );
  }
}

class AnimationScreen extends StatelessWidget {
  final size = window.physicalSize / window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    return new Dots();
  }
}

final size = window.physicalSize / window.devicePixelRatio;

class Dots extends StatefulWidget {
  @override
  _DotsState createState() => _DotsState();
}

class _DotsState extends State<Dots> {
  Offset mousePosition = Offset.zero;

  List<Dot> dots = List.generate(50, (_) => Dot.random(size));

  double speed = 1.5;

  double distanceModifier = 100;

  int lastTimestamp = 0;

  tickAnimation() {
    setState(() => dots.forEach((dot) => dot.move(speed, size)));
  }

  @override
  Widget build(BuildContext context) {
    var ticker = Ticker((elapsed) {
      if (elapsed.inMilliseconds > lastTimestamp + 10) {
        lastTimestamp = elapsed.inMilliseconds;
        tickAnimation();
      }
    });
    ticker.start();
    return GestureDetector(
      onPanUpdate: (details) => setState(() => mousePosition = details.localPosition),
      onPanEnd: (details) => setState(() => mousePosition = null),
      child: CustomPaint(
          size: size,
          painter: DotsPainter(mousePosition, dots, speed, distanceModifier)),
    );
  }
}

class DotsPainter extends CustomPainter {
  static final dotsFill = Paint()..color = Colors.white;

  static final linesFill = Paint()
    ..color = Colors.white
    ..strokeWidth = 0.5;

  final Offset mousePosition;
  final List<Dot> dots;
  final double speed;
  final double distanceModifier;

  const DotsPainter(
      this.mousePosition, this.dots, this.speed, this.distanceModifier);

  @override
  void paint(Canvas canvas, Size size) {
    var maxDistance = distanceModifier * 1.5;

    // Draw lines
    var combinations = Combinations(2, dots);

    combinations().forEach((dotsPair) {
      var dot1 = dotsPair[0];
      var dot2 = dotsPair[1];
      var distance = (dot1.position - dot2.position).distance;
      if (distance < maxDistance) {
        canvas.drawLine(
            dot1.position,
            dot2.position,
            linesFill
              ..color = Colors.white
                  .withAlpha(255 - distance * 255 ~/ maxDistance));
      }
    });
    this.dots.forEach((dot) {
      if (mousePosition != null) {
        var distanceToMouse = (dot.position - mousePosition).distance;
        if (distanceToMouse < maxDistance) {
          canvas.drawLine(
              dot.position,
              mousePosition,
              linesFill
                ..color = Colors.white
                    .withAlpha(255 - distanceToMouse * 255 ~/ maxDistance));
        }
      }
      canvas.drawCircle(dot.position, 2, dotsFill);
    });
  }

  @override
  bool shouldRepaint(DotsPainter oldDelegate) => true;
}
