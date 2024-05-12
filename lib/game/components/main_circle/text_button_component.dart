import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:game_framework/game_framework.dart';

import '../../../constants/images.dart';
import '../../game.dart';
import '../../utils/helper_functions.dart';
import 'big_circle_components.dart';
import 'line_component.dart';
import 'line_end_circle.dart';

//
class TextButtonComponent extends CircleComponent
    with HasGameRef<WordGame>, CollisionCallbacks, TapCallbacks {
  //
  String character;
  Vector2 myPosition;
  bool hasCollided = false;
  bool hasCollidedAgain = false;
  //
  late CircleHitbox circleHitbox;
  late Vector2 myPositionAtRadius;
  late SpriteComponent selectedBg;
  late TextComponent myText;

  final double? radiusT;
  final double? textScale;

  TextButtonComponent? lastTextButton;

  final String _identifier = generateRandomString(30).toString();

  String get identifier => _identifier;

  @override
  BigCircleComponent? get parent => super.parent as BigCircleComponent?;
  //
  // Start Just
  TextButtonComponent({
    required this.character,
    required this.myPosition,
    super.priority,
    this.textScale,
    this.radiusT,
  }) : super(
          position: myPosition,
          radius: radiusT ?? 24,
          paint: Paint()..color = Colors.transparent,
        ) {
    myText = TextComponent(
      text: character,
      scale: Vector2.all(textScale ?? 1.5),
      anchor: Anchor.center,
      position: Vector2.all(24),
      priority: 11,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Portico',
          fontWeight: FontWeight.w400,
          fontSize: 26,
        ),
      ),
    );
    add(myText);
    myPositionAtRadius = myPosition + Vector2.all(radius);
  }

  @override
  Future<void> onLoad() async {
    circleHitbox = CircleHitbox(radius: radius - 5, position: Vector2.all(5));
    // circleHitbox.debugMode = true;
    selectedBg = await loadImage(
      kiChosenLetterBg,
      size: Vector2.all(65),
      position: Vector2.all(-8),
    );
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
    if (myText.text != character) {
      myText.text = character;
    }
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    // paint.color = Colors.green;
    hasCollided = true;
    parent?.tappedButtonPosition = myPositionAtRadius;
    parent?.selectedTextComponentList = {this};
    parent?.currentDraggedPosition = myPositionAtRadius;
    parent?.setUpLine(
      startText: this,
      endText: lastTextButton ?? this,
      start: myPositionAtRadius,
      end: parent?.currentDraggedPosition,
      hasLineEndCircle: true,
      lastText: lastTextButton ?? this,
    );
    parent?.addCharacterInOurDisplayText();
    if (gameRef.isMysteryOn) gameRef.callMystery(character);
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) async {
    (parent)?.reset(removeChildren: false);
    (parent)?.removeWhere((component) => component is LineComponent);
    if ((parent)?.isDragging ?? false) {
      hasCollided = false;
    } else {
      hasCollided = true;
    }
    _cancelTap();
    super.onTapUp(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _cancelTap();
    super.onTapCancel(event);
  }

  _cancelTap() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!((parent)?.isDragging ?? false)) hasCollided = false;
      (parent)?.addCharacterInOurDisplayText();
    });
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    //
    if (other is LineEndCircle && !hasCollided) {
      hasCollided = true;
      hasCollidedAgain = false;
      lastTextButton = parent?.selectedTextComponentList.lastOrNull;
      parent?.selectedTextComponentList = {
        ...(parent?.selectedTextComponentList ?? []),
        this
      };

      if (((other.parent as LineComponent).lastTextComponent) != null) {
        parent?.setUpAllNewLines();
      }
      parent?.tappedButtonPosition = myPositionAtRadius;
      parent?.line?.lastTextComponent = this;

      parent?.addCharacterInOurDisplayText();
    }

    if (other is LineEndCircle && hasCollided && !hasCollidedAgain) {
      // hasCollided = false;

      final lineTextCom = ((other).parent as LineComponent).lastTextComponent;

      if (lineTextCom?.lastTextButton?.identifier == identifier) {
        hasCollidedAgain = true;

        if (parent?.selectedTextComponentList.isNotEmpty ?? false) {
          //
          final element = parent!.selectedTextComponentList.firstWhere(
            (element) => element.identifier == lineTextCom?.identifier,
          );
          //
          final indexedText =
              parent?.selectedTextComponentList.toList().indexOf(element);

          List<TextButtonComponent> list = parent?.selectedTextComponentList
                  .toList()
                  .getRange(0, indexedText!)
                  .toList() ??
              [];

          parent?.selectedTextComponentList = list.toSet();

          final set = parent?.children
                  .whereType<TextButtonComponent>()
                  .toSet()
                  .difference(parent?.selectedTextComponentList ?? {}) ??
              {};
          for (var e in set) {
            e.hasCollided = false;
            e.hasCollidedAgain = false;
            e.lastTextButton = null;
          }
          for (int i = 0; i < list.length; i++) {
            if (i > 0) {
              list[i].hasCollided = true;
              list[i].hasCollidedAgain = false;
            }
          }

          parent?.setUpAllNewLines();
          parent?.tappedButtonPosition = myPositionAtRadius;
          parent?.addCharacterInOurDisplayText();
        }
        parent?.line?.lastTextComponent = this;
      }
    }
  }
}
