import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math.dart';

class Dot {
  Offset position;
  Vector vector;

  Dot(this.position) {
    this.vector = Vector.random();
  }

  move() {
    position = position.translate(cos(radians(vector.angleDegrees)) * vector.magnitude,
        sin(radians(vector.angleDegrees)) * vector.magnitude);
  }

  static Dot random(Size size) {
    double randomX = Random().nextDouble() * size.width;
    double randomY = Random().nextDouble() * size.height;
    Offset position = new Offset(randomX, randomY);
    return new Dot(position);
  }
}

class Vector {
  double magnitude;
  double angleDegrees;

  Vector(this.magnitude, this.angleDegrees);

  static Vector random() {
    double magnitude = Random().nextDouble() + 20;
    double angleDegrees = Random().nextDouble() * 360;
    return new Vector(magnitude, angleDegrees);
  }
}
