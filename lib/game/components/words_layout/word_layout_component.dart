import 'dart:ui';

import 'package:alphatron/game/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'word_component.dart';

class WordLayoutComponent extends PositionComponent with HasGameRef<WordGame> {
  final double spaceBetweenWords = 20;
  final double spaceBetweenRows = 10;

  double spaceBetweenLetters = 3; // Define your text style here
  double rowHeight = 28.0; // Fixed height for each LetterComponent
  Vector2 lettersSize = Vector2.all(28); // Define your text style here
  int noOfRows = 0;
  //

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(0, 170);
    _arrangeWords();
  }

  @override
  void update(double dt) {
    // _arrangeWords();
    super.update(dt);
  }

  void _arrangeWords() async {
    List<Vector2> positions = _calculateWordPositions();
    print("noOfRows $noOfRows");
    final words = game.correctWordsSet.toList();

    // final rect = await loadImage(backSquares,
    //     position: Vector2(-20, -15),
    //     size: Vector2(game.canvasSize.x,
    //         (30 + (rowHeight + spaceBetweenRows) * noOfRows)));
    // add(rect);
    add(RectangleComponent(
      paint: Paint()..color = const Color(0x6C110F0F),
      size: Vector2(
        game.canvasSize.x,
        ((rowHeight + spaceBetweenRows) * (noOfRows + 1)) + 10,
      ),
    ));

    for (int i = 0; i < words.length; i++) {
      var word = words[i];

      final textComponent = WordComponent(
        word,
        spaceBetweenLetters: spaceBetweenLetters,
        spaceBetweenWords: spaceBetweenWords,
        letterSize: lettersSize,
        position: positions[i] + Vector2(0, 10),
      );

      add(textComponent);
    }
  }

  List<Vector2> _calculateWordPositions() {
    final List<Vector3> positions = [];
    double xOffset = 20;
    double yOffset = 0;
    final List<Vector3> lastXOffset = [];

    final totalWordsLengthWithSpace = gameRef.correctWordsSet
            .map((e) => e.length)
            .reduce((value, element) => (value + element)) +
        gameRef.correctWordsSet.length -
        1;

    print("totalWordsLengthWithSpace $totalWordsLengthWithSpace");

    if (totalWordsLengthWithSpace < 20) {
      lettersSize = Vector2.all(36);
    } else if (totalWordsLengthWithSpace < 40 &&
        totalWordsLengthWithSpace >= 20) {
      lettersSize = Vector2.all(34);
    } else if (totalWordsLengthWithSpace < 60 &&
        totalWordsLengthWithSpace >= 40) {
      lettersSize = Vector2.all(32);
    } else if (totalWordsLengthWithSpace < 80 &&
        totalWordsLengthWithSpace >= 60) {
      lettersSize = Vector2.all(30);
    }
    rowHeight = lettersSize.x;

    // ? Calculating how many words can we arrange in a Row & How many rows will have
    for (var word in gameRef.correctWordsSet) {
      // Calculate the width of the word based on the fixed size of LetterComponent
      final estimatedWidth = ((word.length - 1 * spaceBetweenLetters) +
              word.length * lettersSize.x) +
          spaceBetweenWords;

      positions.add(Vector3(xOffset, yOffset, noOfRows.toDouble()));

      // Update the xOffset for the next word, including space
      lastXOffset.add(Vector3(xOffset, yOffset, xOffset + estimatedWidth));
      xOffset += estimatedWidth;

      // Reset xOffset for the next row and increase yOffset by the height of a row
      if (xOffset + estimatedWidth > game.canvasSize.x) {
        xOffset = 0;
        yOffset += rowHeight + spaceBetweenRows;
        ++noOfRows;
      }
    }

    List<double> beginXOffset = [];
    // ? The offset were left align to center it we are calculating the begin offset where the first word of row should start
    for (int i = 0; i < lastXOffset.length; i++) {
      if ((i != 0 && lastXOffset.elementAt(i).x == 0.0)) {
        final previousRowElement = lastXOffset.elementAtOrNull(i - 1);
        if (previousRowElement != null) {
          final x = (game.canvasSize.x - previousRowElement.z) / 2;
          beginXOffset.add(x);
        }
      }
    }

    final x = (game.canvasSize.x - lastXOffset.last.z) / 2;
    beginXOffset.add(x);

    // ? Converting vector3 into vector2 to back to normal with adding begin offset
    List<Vector2> positionsV2 = [];

    for (int i = 0; i < positions.length; i++) {
      //? Z index is no of row in which letters will be start placing
      final pos = Vector2(
          positions.elementAt(i).x +
              beginXOffset[positions.elementAt(i).z.toInt()],
          positions.elementAt(i).y);

      positionsV2.add(pos);
    }

    return positionsV2;
  }
}
