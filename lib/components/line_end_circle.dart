import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

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
