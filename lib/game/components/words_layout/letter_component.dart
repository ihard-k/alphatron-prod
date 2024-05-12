import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/game.dart';
import 'package:alphatron/game/utils/helper_functions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../../../constants/game_const.dart';

class LetterComponent extends PositionComponent
    with HasGameRef<WordGame>, TapCallbacks {
  final String character;
  final TextStyle? textStyle;
  late final TextComponent textComponent;
  final Vector2 letterSize;
  late SpriteComponent emptySquareSprite;
  late SpriteComponent filledSquareSprite;

  bool isVisible = false;
  bool _isAlwaysVisible = false;
  bool get isAlwaysVisible => _isAlwaysVisible;
  String get lastCharacter =>
      isVisible ? character : kDefaultCharacterInLetters;

  final void Function()? onLetterTap;

  LetterComponent(
    this.character, {
    this.textStyle,
    required this.letterSize,
    this.onLetterTap,
  }) {
    // Initialize the text component with the character
    textComponent = TextComponent(
      text: character.toUpperCase(),
      textRenderer: TextPaint(
        style: textStyle ??
            TextStyle(
              fontSize: letterSize.x / 2 + 6,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
      ),
      // Center the text component within the square
      anchor: Anchor.center,
    );
    // Set the size and anchor of the square component
    size = letterSize;
    anchor = Anchor.center;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Add the text component as a child
    emptySquareSprite = await loadImage(emptySquare, size: letterSize);
    filledSquareSprite = await loadImage(
      squareWithLetter,
      size: letterSize,
    );
    add(emptySquareSprite);
    add(filledSquareSprite);
    add(textComponent);
    filledSquareSprite.makeTransparent();
    // Center the text component within the square
    textComponent.position = (size / 2) - Vector2(2, 1);
    textComponent.priority = 3;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (textComponent.text != lastCharacter) {
      textComponent.text = lastCharacter.toUpperCase();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (!_isAlwaysVisible) {
      if (gameRef.isEyeOn) {
        setVisible(true);
      }
    }
    if (onLetterTap != null) onLetterTap!();
    super.onTapDown(event);
  }

  setIsAlwaysVisible(bool isAlwaysVisible) {
    _isAlwaysVisible = isAlwaysVisible;
    setVisible(true);
  }

  setVisible(bool? newValue) {
    isVisible = newValue ?? !isVisible;
    if (isVisible) {
      filledSquareSprite.makeOpaque();
      emptySquareSprite.makeTransparent();
    } else {
      filledSquareSprite.makeTransparent();
      emptySquareSprite.makeOpaque();
    }
    gameRef.clearPowerUp();
  }
}
