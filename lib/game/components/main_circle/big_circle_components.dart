import 'dart:async';
import 'dart:math';
//
import 'package:alphatron/game/components/main_circle/line_component.dart';
import 'package:alphatron/game/components/main_circle/text_button_component.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/utils/helper_functions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../game.dart';
import 'play_pause_button.dart';

class BigCircleComponent extends CircleComponent
    with HasGameRef<WordGame>, DragCallbacks {
  //
  String characterString;
  //

  LineComponent? line;

  bool get isDragging => currentDraggedPosition != null;

  //
  Vector2? currentDraggedPosition;
  Vector2? tappedButtonPosition;

  //
  Set<TextButtonComponent> selectedTextComponentList = {};
  int previousSelectedTextComponentListLength = 0;

  bool isAlphabetsSet = false;
  bool isBgSet = false;
  bool isPaused = false;

  late SwitchImageButton pauseButton;
  //
  BigCircleComponent({required this.characterString})
      : super(
          radius: 130,
          paint: Paint()..color = Colors.transparent,
          anchor: Anchor.center,
        );
  //

  @override
  Future<void> onLoad() async {
    reset();
    await setupCircle();
    setupAlphabets();
    await super.onLoad();
  }

  reset({bool removeChildren = true}) {
    if (removeChildren) removeAll(children);
    line = null;
    isBgSet = false;

    currentDraggedPosition = null;
    tappedButtonPosition = null;

    selectedTextComponentList = {};
  }

  Future<void> setupCircle() async {
    // size = Vector2.all(240);
    if (!isBgSet) {
      isBgSet = true;
      var bg = await loadImage(kiLetterBoard, size: size, priority: 0);
      anchor = Anchor.center;
      position = Vector2(gameRef.size.x / 2, gameRef.size.y - 145);
      add(bg);
      _addPauseButton();
    }
  }

  void setupAlphabets() {
    // !? Optimised SetUp alphapet Method
    if (!isAlphabetsSet) {
      //   //
      isAlphabetsSet = true;

      //
      final int totalCharacters = characterString.length;
      final double innerCharRadius =
          radius - 35 - getAdjustedRadiusAccordingToCharacters(totalCharacters);
      final double angleIncrement = 2 * pi / totalCharacters;
      const double startAngle =
          -pi / 2; // Starting angle at the top (270 degrees)
      final buttons = <TextButtonComponent>[];
      for (int i = 0; i < totalCharacters; i++) {
        //
        final double angle =
            i * angleIncrement + startAngle; // Start from the top
        //
        var adjustedY = 10;
        var adjustedX = 15;

        var xPosition = (innerCharRadius +
            adjustedY +
            getAdjustedRadiusAccordingToCharacters(totalCharacters));

        var yPosition = (innerCharRadius +
            adjustedX +
            getAdjustedRadiusAccordingToCharacters(totalCharacters));

        final Vector2 charPosition = Vector2(
          ((innerCharRadius) * cos(angle)) + xPosition,
          ((innerCharRadius) * sin(angle)) + yPosition,
        );

        final button = TextButtonComponent(
          character: characterString[i],
          myPosition: charPosition,
          priority: 10 + i,
          textScale:
              getAdjustedScaleAccordingToCharactersLength(totalCharacters),
        );
        //
        buttons.add(button);
      }
      //
      addAll(buttons);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    setupCircle();
    setupAlphabets();
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
    pauseButton.removeFromParent();
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    currentDraggedPosition = event.localStartPosition;
  }

  void addCharacterInOurDisplayText() async {
    game.lastWord = selectedTextComponentList.isEmpty
        ? ""
        : selectedTextComponentList
            .map((e) => e.character)
            .reduce((value, element) => "$value$element");
  }

  void addSimpleLineComponent(
    TextButtonComponent currentTextButton,
    TextButtonComponent lastTextButton,
  ) {
    final lineComp = LineComponent(
      startTextComponent: lastTextButton,
      endTextComponent: currentTextButton,
      start: currentTextButton.myPositionAtRadius,
      end: lastTextButton.myPositionAtRadius,
      lastTextComponent: lastTextButton,
    );

    add(lineComp);
  }

  void setUpAllNewLines() {
    //
    try {
      removeAll(
        children
            .whereType<LineComponent>()
            .where((element) => !element.hasEndCircle)
            .toList(),
      );
      //
      List<LineComponent> normalLineComponents = [];

      for (int i = 1; i < selectedTextComponentList.length; i++) {
        final start = selectedTextComponentList.elementAtOrNull(i - 1);
        final end = selectedTextComponentList.elementAtOrNull(i);

        if (start != null && end != null) {
          normalLineComponents.add(
            LineComponent(
              startTextComponent: start,
              endTextComponent: end,
              start: start.myPositionAtRadius,
              end: end.myPositionAtRadius,
              lastTextComponent: end,
            ),
          );
        }
      }

      addAll(normalLineComponents);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    Future.delayed(const Duration(seconds: 2), () {
      game.lastWord = "";
    });

    isAlphabetsSet = false;

    reset();
    setupCircle();
    setupAlphabets();
    super.onDragEnd(event);
  }

  setUpLine(
      {Vector2? start,
      Vector2? end,
      bool hasLineEndCircle = false,
      TextButtonComponent? lastText,
      required TextButtonComponent startText,
      required TextButtonComponent endText}) {
    line = LineComponent(
      startTextComponent: startText,
      endTextComponent: endText,
      start: start ?? Vector2.all(0),
      end: end ?? Vector2.all(0),
      hasEndCircle: hasLineEndCircle,
      lastTextComponent: lastText,
    );
    add(line!);
  }

  void shuffle() async {
    await animateToCenter();
    await animateToNormal();
  }

  Future<void> animateToCenter() async {
    //

    const duration = Duration(milliseconds: 500);
    //
    int steps = duration.inMilliseconds ~/ 20;
    // Animation steps

    final originalPositions = children
        .whereType<TextButtonComponent>()
        .map((e) => e.position.clone())
        .toList();

    Vector2 center = size / 2;

    // Assuming center of the circle
    double maxRadius = 0;
    // Find the maximum radius to use it for calculating the arc
    if (radius > maxRadius) {
      maxRadius = radius;
    }

    for (int step = 0; step <= steps; step++) {
      //
      double progress = step / steps;
      //
      double angleProgress = pi * progress; // Half circle arc

      for (int i = 0; i < originalPositions.length; i++) {
        //
        var currentElement =
            children.whereType<TextButtonComponent>().elementAt(i);
        //
        Vector2 startPosition = originalPositions[i] + currentElement.size / 2;
        double radius = startPosition.distanceTo(center) * (1 - progress);

        // Calculate angle for arc movement based on original angle plus progress
        double startAngle =
            atan2(startPosition.y - center.y, startPosition.x - center.x);

        double newAngle = startAngle + angleProgress;

        // New position based on arc
        Vector2 newPosition = Vector2(
          center.x + radius * cos(newAngle),
          center.y + radius * sin(newAngle),
        );
        currentElement.position = newPosition - currentElement.size / 2;
      }

      await Future.delayed(const Duration(milliseconds: 20));
    }
  }

  Future<void> animateToNormal() async {
    //
    const duration = Duration(milliseconds: 500);
    //
    int steps = duration.inMilliseconds ~/ 20; // Animation steps

    characterString = characterString.shuffleString();
    final textComponents = children.whereType<TextButtonComponent>().toSet();

    List<Vector2> originalPositions =
        textComponents.map((e) => e.myPosition.clone()).toList();

    Vector2 center = Vector2(size.x / 2, size.y / 2) -
        Vector2.all(children
            .whereType<TextButtonComponent>()
            .first
            .radius); // Center of the circle
    double maxRadius = 0;
    // Find the maximum radius to use it for calculating the arc
    for (var position in originalPositions) {
      double radius = position.distanceTo(center);
      if (radius > maxRadius) {
        maxRadius = radius;
      }
    }

    for (int step = 0; step <= steps; step++) {
      double progress = step / steps;
      double angleProgress = pi * (1 - progress); // Inverted half circle arc

      for (int i = 0; i < originalPositions.length; i++) {
        Vector2 finalPosition = originalPositions[i];
        double radius = maxRadius * progress;

        // Calculate angle for arc movement based on final angle minus progress
        double finalAngle =
            atan2(finalPosition.y - center.y, finalPosition.x - center.x);
        double newAngle = finalAngle -
            angleProgress; // Adjust the subtraction for the reverse arc

        // New position based on reverse arc
        Vector2 newPosition = Vector2(
          center.x + radius * cos(newAngle),
          center.y + radius * sin(newAngle),
        );

        textComponents.elementAt(i).position = newPosition;
        textComponents.elementAt(i).character = characterString[i];
      }

      await Future.delayed(const Duration(milliseconds: 20));
    }
  }

  void _addPauseButton() async {
    pauseButton = PlayPauseButton(
      position: size / 2 - Vector2(2, -3),
      onClick: () {
        // game.paused ? game.resumeEngine() : game.pauseEngine();
      },
    );
    add(pauseButton);
  }

  int getAdjustedRadiusAccordingToCharacters(int totalCharacters) {
    if (totalCharacters < 4) {
      return 12;
    } else if (totalCharacters >= 4 && totalCharacters < 7) {
      return 10;
    } else {
      return 6;
    }
  }

  double getAdjustedScaleAccordingToCharactersLength(int totalCharacters) {
    if (totalCharacters < 4) {
      return 2.1;
    } else if (totalCharacters >= 4 && totalCharacters < 7) {
      return 1.8;
    } else {
      return 1.5;
    }
  }
}
