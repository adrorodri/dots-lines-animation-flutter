import 'dart:ui';

import 'package:flutter/material.dart';

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
    return GestureDetector(onTap: () {}, child: Board());
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

final size = window.physicalSize / window.devicePixelRatio;

class _BoardState extends State<Board> {
  Offset mouse = Offset.zero;
  List<Dot> dots = List.filled(200, Dot.random(size));

  startAnimating() {
    while (true) {
      dots.forEach((dot) => dot.move());
    }
  }

  _BoardState() {
    startAnimating();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onPanUpdate: (details) => setState(() => mouse = details.localPosition),
        child: CustomPaint(size: size, painter: Painter(mouse, dots)),
      );
}

class Painter extends CustomPainter {
  static const radius = 10.0;

  static final fill = Paint()..color = Colors.red;

  final Offset position;
  final List<Dot> dots;

  const Painter(this.position, this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(position, radius, fill);
    this.dots.forEach((dot) {
      canvas.drawCircle(dot.position, 1, fill);
    });
  }

  @override
  bool shouldRepaint(Painter oldDelegate) => position != oldDelegate.position;
}
