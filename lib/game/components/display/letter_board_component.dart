import 'package:alphatron/game/game.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/utils/helper_functions.dart';
import 'package:flame/components.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

import '../../index.dart';
import 'blurred_text_box_component.dart';
import 'timer_component.dart';

class LetterBoardComponent extends PositionComponent with HasGameRef<WordGame> {
  //
  late final AnimatedTextComponent _textBox;
  late final BandComponent _bandTextBox;
  late RotatableTextComponent _scoreText;
  late TextBoxComponent roundText;
  late TextBoxComponent totalScoreText;
  //

  String text = "";
  late MyTimerComponent _timer;

  final double _displayFrameY = 80;

  late OneShotAnimation animaCon;

  final textStyle = TextPaint(
    style: ktPerfogmaDisplay,
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size =
        Vector2(gameRef.canvasSize.x > 420 ? 420 : gameRef.canvasSize.x, 120);
    anchor = Anchor.center;
    position = Vector2(
      gameRef.canvasSize.x / 2,
      gameRef.canvasSize.y - gameRef.bigCircleComp.size.y - 83,
    );

    _addDisplayFrameAndRoundAndScoreBoard();
    _addLetters();
    _addTimer();
    animaCon = OneShotAnimation('Play', autoplay: false, onStop: () {});
  }

  //
  void _addTimer() {
    _timer = MyTimerComponent(
      duration: gameRef.gameModel?.roundLength.roundToDouble() ?? 10.0,
      position: Vector2(size.x / 2, 15),
      onComplete: () {
        // remove(_textBox);
        // remove(_scoreText);
        displayBand(text: "Game Over!", speed: 3);
      },
    );
    _timer.priority = 120;
    add(_timer);
  }

  void _addLetters() {
    //
    //     anchor: Anchor.bottomRight, position: Vector2(canvasSize.x - 100, 80));
    _textBox = AnimatedTextComponent(
      priority: 310,
      anchor: Anchor.topLeft,
      boxConfig: TextBoxConfig(growingBox: true, timePerChar: 0.5),
      textRenderer: textStyle,
      children: [
        AnimatedTextComponent(
          priority: -10,
          boxConfig: TextBoxConfig(growingBox: true, timePerChar: 0.5),
        )
      ],
    );
    _bandTextBox = BandComponent(
      text: "",
      screenSize: size.x,
      priority: 106,
      anchor: Anchor.topLeft,
      boxConfig: TextBoxConfig(growingBox: true, maxWidth: gameRef.size.y - 30),
      textRenderer: textStyle,
      position: Vector2(
        width,
        45,
      ),
    );

    _scoreText = RotatableTextComponent(
      priority: 310,
      position: Vector2(size.x / 2, size.y / 2 + 10),
      boxConfig: TextBoxConfig(growingBox: true),
      isScaleAndDisappear: true,
      textRenderer: TextPaint(style: ktPerfogmaLess),
    );

    add(_scoreText);

    // _bandTextBox.debugMode = true;
    // bandTextBox.startScroll(speed: 3);
    add(_textBox);
    add(_bandTextBox);
  }

  @override
  void update(double dt) {
    super.update(dt);
    _changeText();
    _changeFontSize();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size.x > 420 ? Vector2(420, y) : size);
  }

  void _changeText() {
    _textBox.text = text;

    if (text.isNotEmpty) {
      _bandTextBox.stopScroll();
    }

    const calY = 42.0;

    _textBox.position = Vector2(((size.x - _textBox.size.x) / 2), calY);
    final childText = (_textBox.children.firstOrNull as AnimatedTextComponent?);
    childText?.position =
        Vector2((_textBox.size.x - childText.size.x / 2), childText.size.y / 2);

    final lastCharacter = text.isNotEmpty ? text[text.length - 1] : "";
    if (lastCharacter != childText?.text) {
      childText?.text = lastCharacter;
      game.letterBoardComp.animaCon.isActive = lastCharacter != "";
      childText?.scaleAndDisappear();
    }
  }

  void _addDisplayFrameAndRoundAndScoreBoard() async {
    //
    final canvasSize = size;

    RectangleComponent rect =
        RectangleComponent(paint: Paint()..color = Colors.black);
    rect.size = Vector2(canvasSize.x - 18, _displayFrameY);
    rect.priority = 105;
    rect.position = Vector2(10, 32);

    add(rect);
    SpriteComponent image = await loadImage(
      display,
      size: size,
      priority: 110,
    );

    // save
    add(image);

    roundText = TextBoxComponent(
      text: "ROUND 23B",
      priority: 208,
      size: Vector2(100, 30),
      align: Anchor.center,
      position: Vector2(gameRef.canvasSize.x / 2 - 170, 5),
      textRenderer: TextPaint(
          style: ktPorticoWhiteWithBlackShadow.copyWith(fontSize: 14)),
    );
    totalScoreText = TextBoxComponent(
      text: "1654",
      priority: 208,
      size: Vector2(100, 30),
      align: Anchor.center,
      position: Vector2(gameRef.canvasSize.x / 2 + 70, 5),
      textRenderer: TextPaint(
          style: ktPorticoWhiteWithBlackShadow.copyWith(fontSize: 14)),
    );
    add(roundText);
    add(totalScoreText);

    image = await loadImage(displayFrame);
    image.size = Vector2(canvasSize.x - 15, _displayFrameY);
    image.priority = 206;
    image.position = Vector2(8, 32);
    add(image);

    image = await loadImage(channel);
    image.size = Vector2(80, 105);
    image.priority = 207;
    image.opacity = 0.9;
    image.position = Vector2(canvasSize.x - 130, 88);
    add(image);

    final artBoard =
        await loadArtboard(RiveFile.asset("assets/animation/ball.riv"));

    final riveComponent = RiveComponent(
      artboard: artBoard,
      size: Vector2(80, 130),
      priority: 262,
      position: Vector2(canvasSize.x - 132, 85),
    );
    artBoard.addController(animaCon);
    add(riveComponent);
  }

  void _changeFontSize() {
    //
    double fontSize = 54.0;
    //
    if (text.isNotEmpty && text.length < 3) {
      fontSize += 12;
    } else if (text.length >= 3 && text.length < 6) {
      fontSize += 10;
    } else if (text.length >= 6 && text.length < 8) {
      fontSize += 8;
    } else if (text.length >= 8 && text.length < 11) {
      fontSize += -2;
    }

    //
    _textBox.textRenderer = TextPaint(
      style: textStyle.style.copyWith(
        fontSize: fontSize,
      ),
    );

    final childText = (_textBox.children.firstOrNull as TextBoxComponent?);
    childText?.textRenderer = TextPaint(
      style: textStyle.style.copyWith(
        fontSize: fontSize,
        color: Colors.red.shade100.withOpacity(0.6),
        shadows: [],
      ),
    );
  }

  var lastText = "";

  score(int points, String? text) {
    if (text != lastText) {
      lastText = text!;
      removeWhere((component) => component is AnimatedTextComponent);
      _textBox.text = "";
      _scoreText = RotatableTextComponent(
        text: points.toString(),
        priority: 310,
        position: Vector2(size.x / 2, size.y / 2 + 20),
        boxConfig: TextBoxConfig(growingBox: true),
        isScaleAndDisappear: true,
        textRenderer: TextPaint(style: ktPerfogmaLess),
        onComplete: () async {
          await Future.delayed(const Duration(milliseconds: 1350));
          add(_textBox);
        },
      );

      add(_scoreText);
    }
  }

  displayBand({String? text, double speed = 1, int scroll = 3}) {
    _bandTextBox.startScroll(text: text, speed: speed, scroll: scroll);
  }
}
