import 'dart:async';
import 'dart:math';
import 'package:alphatron/components/line_component.dart';

import 'package:alphatron/components/text_button_component.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../game/my_game.dart';

class BigCircleComponents extends CircleComponent
    with HasGameRef<MyGame>, DragCallbacks {
  String characterString;

  String word = "";
  BigCircleComponents({required this.characterString})
      : super(
          radius: 130,
          paint: Paint()..color = Colors.transparent,
          anchor: Anchor.center,
        );

  //
  LineComponent? line;

  bool get isDragging =>
      currentDraggedPosition != null && currentSelectedTextComponent != null;

  Vector2? currentDraggedPosition;
  Vector2? tappedButtonPosition;
  TextButtonComponent? currentSelectedTextComponent;
  Set<TextButtonComponent> selectedTextComponentList = {};
  Set<TextButtonComponent> previousSelectedTextComponentList = {};

  bool hasDraggingStartFromAButton = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    reset();
    setupCircle();

    setupAlphabets();
  }

  void _addBackground() async {
    var bg = await loadImage(letterboard, size: size, priority: 0);
    add(bg);
  }

  reset() {
    removeAll(children);
    line = null;
    word = "";
    hasDraggingStartFromAButton = false;
    currentDraggedPosition = null;
    tappedButtonPosition = null;
    currentSelectedTextComponent = null;
    selectedTextComponentList = {};
    previousSelectedTextComponentList = {};
  }

  void setupCircle() {
    position = gameRef.size - Vector2(gameRef.size.x / 2, 200);
    _addBackground();
    _addPauseButton();
  }

  void setupAlphabets() {
    final int totalCharacters = characterString.length;
    final double newRadius = (size.x / 2 - 35);
    final double angleIncrement = 2 * pi / totalCharacters;
    const double startAngle =
        -pi / 2; // Starting angle at the top (270 degrees)

    for (int i = 0; i < totalCharacters; i++) {
      final double angle =
          i * angleIncrement + startAngle; // Start from the top
      final Vector2 charPosition = Vector2(
        ((newRadius) * cos(angle)) + (newRadius + 10),
        ((newRadius) * sin(angle)) + (newRadius + 15),
      );

      final button = TextButtonComponent(
        character: characterString[i],
        myPosition: charPosition,
        priority: 10 + i,
      );
      add(button);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    setupCircle();
    setupAlphabets();
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    // paint.color = isDragged ? Colors.blue : Colors.red;
    if (isDragged &&
        tappedButtonPosition != null &&
        currentDraggedPosition != null) {
      line?.start = tappedButtonPosition!;
      line?.end = currentDraggedPosition!;
    }
    super.update(dt);
  }

  @override
  void onDragStart(DragStartEvent event) {
    // location of user's tap
    final touchPoint = event.canvasPosition;
    // print("touch point : $touchPoint");

    //
    // handle the tap action
    hasDraggingStartFromAButton = checkIfAnyButtonIsTouched(touchPoint);
    if (hasDraggingStartFromAButton) setUpLine(hasLineEndCircle: true);
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final touchPoint = event.canvasStartPosition;
    currentDraggedPosition = event.localStartPosition;

    final hasAnyButtonTouched = checkIfAnyButtonIsTouched(touchPoint);
    if (hasDraggingStartFromAButton) addCharacterInOurDisplayText();
    if (hasAnyButtonTouched && hasDraggingStartFromAButton) {
      if (previousSelectedTextComponentList.length !=
          selectedTextComponentList.length) {
        //
        // print(selectedTextComponentList.map((e) => e.character).toList());
        //
        for (int i = 0; i < selectedTextComponentList.length - 1; i++) {
          int j = i + 1;

          final lastTextButton = selectedTextComponentList.elementAtOrNull(i);
          final currentTextButton =
              selectedTextComponentList.elementAtOrNull(j);

          bool doesLastButtonAndCurrentButtonExist =
              lastTextButton != null && currentTextButton != null;

          if (doesLastButtonAndCurrentButtonExist) {
            //
            _addSimpleLineComponent(currentTextButton, lastTextButton);
            // ! if collision is missed then setting externally to fix the bug
            currentTextButton.hasCollided = true;
          }
        }

        previousSelectedTextComponentList = selectedTextComponentList;
      }
    }
    super.onDragUpdate(event);
  }

  void addCharacterInOurDisplayText() {
    game.lastWord = selectedTextComponentList
        .map((e) => e.character)
        .reduce((value, element) => "$value$element");
  }

  void _addSimpleLineComponent(TextButtonComponent currentTextButton,
      TextButtonComponent lastTextButton) {
    add(
      LineComponent(
        start: currentTextButton.myPositionPlusRadius,
        end: lastTextButton.myPositionPlusRadius,
      ),
    );
  }

  @override
  void onDragEnd(DragEndEvent event) {
    Future.delayed(const Duration(seconds: 2), () {
      game.lastWord = "";
    });
    reset();
    setupCircle();
    setupAlphabets();
    super.onDragEnd(event);
  }

  bool checkIfAnyButtonIsTouched(Vector2 touchPoint) {
    return children.any((component) {
      //
      //

      final hasNewTextButtonTouched = component.containsPoint(touchPoint) &&
          !selectedTextComponentList
              .any((element) => element.containsPoint(touchPoint));

      if (component is TextButtonComponent && hasNewTextButtonTouched) {
        currentSelectedTextComponent = component;

        if (currentSelectedTextComponent != null && line?.circle != null) {
          if (currentSelectedTextComponent!.collidingWith(line!.circle!)) {
            currentSelectedTextComponent!.hasCollided = true;
          }
        }

        selectedTextComponentList = {
          ...selectedTextComponentList,
          currentSelectedTextComponent!
        };

        tappedButtonPosition =
            currentSelectedTextComponent!.myPositionPlusRadius;

        return true;
      }
      return false;
    });
  }

  setUpLine({Vector2? start, Vector2? end, bool hasLineEndCircle = false}) {
    line = LineComponent(
      start: start ?? Vector2.all(0),
      end: end ?? Vector2.all(0),
      hasEndCircle: hasLineEndCircle,
    );
    add(line!);
  }

  void _addPauseButton() async {
    final buttonBg = await loadImage(
      buttonSilver,
      size: Vector2.all(90),
      priority: 20,
      anchor: anchor,
      position: size / 2 - Vector2(2, -3),
    );
    final pIcon = await loadImage(
      pauseIcon,
      size: Vector2.all(40),
      priority: 21,
      anchor: anchor,
      position: size / 2 - Vector2(2, -3),
    );
    add(buttonBg);
    add(pIcon);
  }
}
