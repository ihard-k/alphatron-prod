import 'dart:async';
import 'package:alphatron/components/big_circle_components.dart';
import 'package:alphatron/components/line_end_circle.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

//
//
//
class TextButtonComponent extends CircleComponent
    with CollisionCallbacks, TapCallbacks {
  //
  //
  String character;
  Vector2 myPosition;
  bool hasCollided = false;
  int _timesCollided = 0;
  //
  late CircleHitbox circleHitbox;
  late Vector2 myPositionPlusRadius;
  late SpriteComponent selectedBg;
  // 
  // Start Just 
  // 
  TextButtonComponent(
      {required this.character, required this.myPosition, super.priority})
      : super(
          position: myPosition,
          radius: 24,
          paint: Paint()..color = Colors.transparent,
          children: [
            TextComponent(
              text: character,
              scale: Vector2.all(1.5),
              textRenderer: TextPaint(
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              anchor: Anchor.center,
              position: Vector2.all(24),
              priority: 11,
            ),
          ],
        ) {
    myPositionPlusRadius = myPosition + Vector2.all(radius);
  }

  @override
  Future<void> onLoad() async {
    circleHitbox = CircleHitbox(radius: radius - 5, position: Vector2.all(5));
    // circleHitbox.debugMode = true;
    selectedBg = await loadImage(choosenLetterBg,
        size: Vector2.all(65), position: Vector2.all(-8));
    add(selectedBg);
    add(circleHitbox);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (hasCollided) {
      selectedBg.makeOpaque();
    } else {
      selectedBg.makeTransparent();
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // paint.color = Colors.green;
    hasCollided = true;

    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    if ((parent! as BigCircleComponents).isDragging) {
      hasCollided = false;
    } else {
      hasCollided = true;
    }
    super.onTapUp(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (parent is BigCircleComponents) {
        if (!(parent as BigCircleComponents).isDragging) hasCollided = false;
      }
    });
    super.onTapCancel(event);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is LineEndCircle && !hasCollided) {
      hasCollided = true;
      ++_timesCollided;
    }
  }
}
