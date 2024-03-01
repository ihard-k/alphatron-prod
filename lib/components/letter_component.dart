import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class LetterComponent extends PositionComponent {
  final String character;
  final TextStyle? textStyle;
  late final TextComponent textComponent;
  final Vector2 letterSize;
  late SpriteComponent emptySquareSprite;
  late SpriteComponent filledSquareSprite;

  LetterComponent(
    this.character, {
    this.textStyle,
    required this.letterSize,
  }) {
    // Initialize the text component with the character
    textComponent = TextComponent(
      text: character,
      textRenderer: TextPaint(
        style: textStyle ??
            const TextStyle(
              fontSize: 18,
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
    filledSquareSprite = await loadImage(squareWithLetter,
        size: letterSize + Vector2.all(6), position: Vector2.all(-3));
    add(emptySquareSprite);
    add(filledSquareSprite);
    add(textComponent);
    filledSquareSprite.makeTransparent();
    // Center the text component within the square
    textComponent.position = size / 2;
    textComponent.priority = 3;
  }

  @override
  void update(double dt) {
    if (character != " ") {
      filledSquareSprite.makeOpaque();
      emptySquareSprite.makeTransparent();
    } else {
      filledSquareSprite.makeTransparent();
      emptySquareSprite.makeOpaque();
    }
    super.update(dt);
  }
}
