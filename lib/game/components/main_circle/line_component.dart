import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'line_end_circle.dart';
import 'text_button_component.dart';

class LineComponent extends ShapeComponent {
  //
  Vector2 start;
  Vector2 end;
  LineEndCircle? circle;
  bool hasEndCircle;
  TextButtonComponent? startTextComponent;
  TextButtonComponent? endTextComponent;
  TextButtonComponent? lastTextComponent;
  late Offset topPoint;
  late Offset leftPoint;
  late Offset rightPoint;

  //
  LineComponent({
    required this.start,
    required this.end,
    Paint? paint,
    required this.startTextComponent,
    this.endTextComponent,
    this.lastTextComponent,
    this.hasEndCircle = false,
  }) : super() {
    //
    this.paint = paint ?? Paint()
      ..color = const Color(0xB5FF8E8E)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.9)
      // ..blendMode = BlendMode.hardLight
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    anchor = Anchor.center;

    if (hasEndCircle) {
      //
      circle = LineEndCircle(
        radius: 8,
        paint: Paint()..color = Colors.red,
        position: end,
      );

      add(circle!);
    }
  }

  Vector2 getDirection() {
    return end - start;
  }

  double getAngleToEnd() {
    Vector2 direction = getDirection();
    return math.atan2(direction.y, direction.x); // Angle in radians
  }

  double getAngleInDegrees() {
    return getAngleToEnd() * (180 / math.pi); // Convert radians to degrees
  }

  bool getAngleInBetweenRadian(double angle) {
    return angle > getAngleInDegrees() - 5 &&
        angle < getAngleInDegrees() + 5; // Convert radians to degrees
  }

  @override
  update(double dt) {
    if (hasEndCircle) {
      circle!.position = end - Vector2.all(8);

      // triangle!.angle = getAngleInDegrees();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(start.toOffset(), 5, paint);
    canvas.drawCircle(end.toOffset(), 5, paint);
    canvas.drawLine(start.toOffset(), end.toOffset(), paint);

    // _drawTrianlge(canvas);
  }

  void _drawTrianlge(Canvas canvas) {
    Paint paint2 = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final angle =
        getAngleToEnd().isNegative ? getAngleToEnd() : -getAngleToEnd();

    const triangleSize = 20.0; // Size of the equilateral triangle
    final midPoint = end.toOffset();

    final triangleHeight = triangleSize * sqrt(3) / 2;

    final path = Path();

    // Calculating triangle points
    final point1 = midPoint +
        Offset(
          cos(angle + pi / 2) * triangleSize / 2,
          sin(angle + pi / 2) * triangleSize / 2 + triangleHeight / 2,
        );
    final point2 = midPoint +
        Offset(
          cos(angle - pi / 2) * triangleSize / 2,
          sin(angle - pi / 2) * triangleSize / 2 + triangleHeight / 2,
        );
    final point3 = midPoint +
        Offset(
          cos(angle) * triangleSize / 2,
          sin(angle) * triangleSize / 2 - triangleHeight / 2,
        );

    // Drawing triangle
    path.moveTo(point1.dx, point1.dy);
    path.lineTo(point2.dx, point2.dy);
    path.lineTo(point3.dx, point3.dy);
    path.close();

    // canvas.drawPath(path, _paint);

    canvas.drawPath(path, paint2);
  }
}
