import 'package:alphatron/game/my_game.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'blured_text_box_component.dart';

class LetterBoardComponent extends PositionComponent with HasGameRef<MyGame> {
  late final TextBoxComponent _text;
  late final BlurredTextBoxComponent _textBG;
  String text = "";

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(0, (gameRef.canvasSize.y / 2) - 30);
    _addBackground();
    _addLetterBoardComponent();
  }

  void _addBackground() async {
    final image = await loadImage(
      display,
      size: Vector2(gameRef.canvasSize.x, 120),
      priority: 0,
    );
    add(image);
  }

  void _addLetterBoardComponent() {
    final canvasSize = gameRef.size;

    _textBG = BlurredTextBoxComponent(
      position: Vector2(0, 20),
      size: Vector2(canvasSize.x, 120),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Perfograma',
          color: Colors.red.shade900,
          fontSize: 54,
          fontWeight: FontWeight.w900,
        ),
      ),
      color: Colors.red.shade900,
    );

    _text = TextBoxComponent(
      position: Vector2(0, 20),
      align: Anchor.center,
      size: Vector2(canvasSize.x, 120),
      priority: 10,
      textRenderer: TextPaint(
        style: TextStyle(
            fontFamily: 'Perfograma',
            color: const Color.fromARGB(255, 255, 44, 41),
            fontSize: 54,
            fontWeight: FontWeight.w200,
            background: Paint()
              ..color = Colors.transparent
              ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.9)),
      ),
    );

    add(_textBG);
    add(_text);
  }

  @override
  void update(double dt) {
    _textBG.text = text;
    _text.text = text;
    super.update(dt);
  }
}
