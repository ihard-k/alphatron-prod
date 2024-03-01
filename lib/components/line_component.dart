import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'line_end_circle.dart';

class LineComponent extends ShapeComponent {
  Vector2 start;
  Vector2 end;
  LineEndCircle? circle;
  bool hasEndCircle;

  //
  LineComponent({
    required this.start,
    required this.end,
    Paint? paint,
    this.hasEndCircle = false,
  }) : super() {
    this.paint = paint ?? Paint()
      ..color = Colors.yellow
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.9)
      ..blendMode = BlendMode.hardLight
      ..strokeWidth = 10;

    anchor = Anchor.center;

    if (hasEndCircle) {
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

  @override
  update(double dt) {
    if (hasEndCircle) circle!.position = end - Vector2.all(8);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(start.toOffset(), 5, paint);
    canvas.drawCircle(end.toOffset(), 5, paint);
    canvas.drawLine(start.toOffset(), end.toOffset(), paint);
  }
}
