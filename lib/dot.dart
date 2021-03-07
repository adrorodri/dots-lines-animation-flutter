import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math.dart';

class Dot {
  Offset position;
  Vector vector;

  Dot(this.position) {
    this.vector = Vector.random();
  }

  move(double speed, Size bounds) {
    position = position.translate(
        speed * vector.magnitudex, speed * vector.magnitudey);
    if (position.dx > bounds.width) {
      position = position.translate(-bounds.width, 0);
    }
    if (position.dx < 0) {
      position = position.translate(bounds.width, 0);
    }
    if (position.dy > bounds.height) {
      position = position.translate(0, -bounds.height);
    }
    if (position.dy < 0) {
      position = position.translate(0, bounds.height);
    }
  }

  static Dot random(Size size) {
    double randomX =
        Random(DateTime.now().microsecond).nextDouble() * size.width;
    double randomY =
        Random(DateTime.now().microsecond).nextDouble() * size.height;
    Offset position = new Offset(randomX, randomY);
    return new Dot(position);
  }
}

class Vector {
  double magnitude;
  double angleDegrees;
  double magnitudex;
  double magnitudey;

  Vector(this.magnitude, this.angleDegrees) {
    magnitudex = magnitude * cos(radians(angleDegrees));
    magnitudey = magnitude * sin(radians(angleDegrees));
  }

  static Vector random() {
    double magnitude = Random(DateTime.now().microsecond).nextDouble();
    double angleDegrees = Random(DateTime.now().microsecond).nextDouble() * 360;
    return new Vector(magnitude, angleDegrees);
  }
}
