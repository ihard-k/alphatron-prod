import 'package:flame/components.dart';

import 'letter_component.dart';

class WordComponent extends PositionComponent {
  final String word;
  final double spaceBetweenLetters; // Space between letters
  final double spaceBetweenWords; // Space between letters
  final Vector2 letterSize; // Space between letters

  WordComponent(this.word,
      {required this.spaceBetweenLetters,
      required this.spaceBetweenWords,
      required this.letterSize});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    double xOffset = 0;

    for (var i = 0; i < word.length; i++) {
      final character = word[i];
      final letterComponent = LetterComponent(
        character,
        letterSize: letterSize,
      )..position = Vector2(xOffset, 0);
      add(letterComponent);

      // Update xOffset for the next character, including space
      xOffset += letterComponent.size.x + spaceBetweenLetters;
    }

    size = Vector2(xOffset, letterSize.y);
  }
}
