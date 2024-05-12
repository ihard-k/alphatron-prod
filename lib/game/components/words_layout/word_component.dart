import 'package:alphatron/constants/game_const.dart';
import 'package:alphatron/game/game.dart';
import 'package:flame/components.dart';

import 'letter_component.dart';

class WordComponent extends PositionComponent with HasGameRef<WordGame> {
  final String word;
  final double spaceBetweenLetters; // Space between letters
  final double spaceBetweenWords; // Space between letters
  final Vector2 letterSize; // Space between letters
  bool visible = false;
  WordComponent(
    this.word, {
    required Vector2 position,
    required this.spaceBetweenLetters,
    required this.spaceBetweenWords,
    required this.letterSize,
  }) : super(position: position);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    double xOffset = 0;
    for (var i = 0; i < word.length; i++) {
      final character = word[i];
      final letterComponent =
          LetterComponent(character, letterSize: letterSize, onLetterTap: () {
        if (visible) {
          gameRef.overlays.add(ksDictionaryOverlay);
        }
        if (gameRef.isStarOn) {
          blink();
        }
      })
            ..position = Vector2(xOffset + letterSize.x / 2, letterSize.y / 2);
      add(letterComponent);
      xOffset += letterComponent.size.x + spaceBetweenLetters;
    }
  }

  void show(bool value) {
    visible = value;
    children.whereType<LetterComponent>().forEach((e) {
      e.setIsAlwaysVisible(value);
    });
  }

  void blink() {
    final visibleList = <bool>[];
    for (var child in children.whereType<LetterComponent>()) {
      visibleList.add(child.isVisible);
      child.setVisible(false);
    }

    final blinkCounter = TimerComponent(
      period: 0.2,
      repeat: true,
      onTick: toggleLettersVisibility,
    );

    final blinkStopCounter = TimerComponent(
      period: 2,
      repeat: false,
      onTick: () {
        remove(blinkCounter);
        gameRef.clearPowerUp();
        for (var (i, child) in children.whereType<LetterComponent>().indexed) {
          child.setVisible(visibleList[i]);
        }
      },
      removeOnFinish: true,
    );

    add(blinkCounter);
    add(blinkStopCounter);
  }

  void toggleLettersVisibility() {
    for (var child in children.whereType<LetterComponent>()) {
      child.setVisible(!child.isVisible);
    }
  }
}
