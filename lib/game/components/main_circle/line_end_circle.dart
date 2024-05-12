import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LineEndCircle extends CircleComponent {
  LineEndCircle({
    super.radius,
    super.paint,
    super.position,
  }) : super(priority: 10);

  @override
  Future<void> onLoad() async {
    add(CircleHitbox(radius: radius - 5));
    await super.onLoad();
  }
}

class LineEndTriangle extends PositionComponent {
  Paint? paint;
  double angleL;

  LineEndTriangle({
    super.position,
    this.paint,
    required this.angleL,
    super.size, // Adjust the size as needed
  });

  List<Vector2> rotatedPoints = [];

  @override
  Future<void> onLoad() async {
    final trianglePoints = [
      Vector2(0, size.y), // Bottom left point
      Vector2(size.x / 2, 0), // Top point
      Vector2(size.x, size.y), // Bottom right point
    ];

    rotatedPoints = _rotatePoints(trianglePoints, angleL);

    add(
      PolygonHitbox(rotatedPoints),
    );

    await super.onLoad();
  }

  @override
  void render(Canvas c) {
    super.render(c);

    // Draw triangle
    final Path path = Path();
    final trianglePoints = [
      Vector2(size.x / 2, 0), // Top point
      Vector2(0, size.y), // Bottom left point
      Vector2(size.x, size.y), // Bottom right point
    ];
    final rotatedPoints = _rotatePoints(trianglePoints, angleL);
    path.moveTo(rotatedPoints[0].x, rotatedPoints[0].y);
    path.lineTo(rotatedPoints[1].x, rotatedPoints[1].y);
    path.lineTo(rotatedPoints[2].x, rotatedPoints[2].y);
    path.close();
    c.drawPath(
        path,
        paint ?? Paint()
          ..color = Colors.red);
  }

  List<Vector2> _rotatePoints(List<Vector2> points, double angle) {
    final List<Vector2> rotatedPoints = [];

    final double cosAngle = cos(angle);
    final double sinAngle = sin(angle);

    for (final point in points) {
      final double rotatedX =
          (point.x * cosAngle.abs()) - (point.y * sinAngle.abs());
      final double rotatedY =
          (point.x * sinAngle.abs()) + (point.y * cosAngle.abs());
      rotatedPoints.add(Vector2(rotatedX, rotatedY));
    }

    return rotatedPoints;
  }
}
