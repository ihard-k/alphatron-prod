import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/my_game.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'word_component.dart';

class WordLayoutComponent extends PositionComponent with HasGameRef<MyGame> {
  final Vector2 screenSize;
  final double spaceBetweenWords;
  final double spaceBetweenRows;
  final textStyle = const TextStyle(fontSize: 22);

  int spaceBetweenLetters = 10; // Define your text style here
  final lettersSize = Vector2.all(20); // Define your text style here
  double rowHeight = 20.0; // Fixed height for each LetterComponent
  int noOfRows = 1;
  WordLayoutComponent({
    required this.screenSize,
    this.spaceBetweenWords = 20,
    this.spaceBetweenRows = 10,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(20, 150);
    // size = Vector2(200, 100);
    // anchor = Anchor.center;
    _arrangeWords();
  }

  @override
  void update(double dt) {
    // _arrangeWords();
    super.update(dt);
  }

  void _arrangeWords() async {
    List<Vector2> positions = _calculateWordPositions();
    final words = game.correctWordsSet.toList();
    final guessedWords = game.correcGussedtWordsSet.toList();
    final rect = await loadImage(backSquares,
        position: Vector2.all(-22),
        size: Vector2(game.canvasSize.x + 7,
            positions.last.y + (2.5 * rowHeight * noOfRows)));
    add(rect);

    for (int i = 0; i < words.length; i++) {
      var word = words[i];
      var displayWord = guessedWords.contains(word) ? word : ' ' * word.length;

      final textComponent = WordComponent(
        displayWord,
        spaceBetweenLetters: 2,
        spaceBetweenWords: spaceBetweenWords,
        letterSize: lettersSize,
      );

      textComponent.position = positions[i];
      add(textComponent);
    }
  }

  List<Vector2> _calculateWordPositions() {
    final List<Vector2> positions = [];
    double xOffset = 0;
    double yOffset = 0;

    for (var word in gameRef.correctWordsSet) {
      // Calculate the width of the word based on the fixed size of LetterComponent
      final estimatedWidth =
          (word.length * lettersSize.x + (word.length - 1)) + spaceBetweenWords;

      // Check if adding the next word would exceed the width of the WordLayoutComponent
      if (xOffset + estimatedWidth > screenSize.x) {
        // Move to the next row
        xOffset = 0;
        yOffset += rowHeight + spaceBetweenRows;
        ++noOfRows;
      }

      positions.add(Vector2(xOffset, yOffset));

      // Update the xOffset for the next word, including space
      xOffset += estimatedWidth;

      // Reset xOffset for the next row and increase yOffset by the height of a row
      if (xOffset + estimatedWidth > screenSize.x) {
        xOffset = 0;
        yOffset += rowHeight + spaceBetweenRows;
      }
    }

    return positions;
  }
}
