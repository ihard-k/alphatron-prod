import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import 'package:alphatron/constants/colors.dart';
import 'package:alphatron/constants/game_const.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/utils/helper_functions.dart';

import '../../../constants/theme.dart';

abstract class IButtonType {}

class NormalButton extends IButtonType {
  NormalButton();
}

class BadgeButton extends IButtonType {
  final Vector2 position;
  final int badge;
  BadgeButton({
    required this.position,
    required this.badge,
  });
}

class ExtraBottomButton extends IButtonType {
  late Vector2 position;
  final String? imageAsset;
  final Vector2? imagePosition;
  final Vector2? imageSize;
  final String text;
  ExtraBottomButton({
    Vector2? position,
    this.imageAsset,
    this.imagePosition,
    this.imageSize,
    required this.text,
  }) {
    this.position = position ?? Vector2(-5, 45);
  }
}

class GameUiButton extends PositionComponent with TapCallbacks {
  String iconAsset;
  final void Function() onClick;
  final Vector2? iconSize;
  final Vector2? iconPosition;
  late UiButtonBG buttonBGSprite;
  final double? progress;
  final int? maxStep;
  late IButtonType buttonType;
  TextComponent? badgeText;

  //
  GameUiButton({
    required this.iconAsset,
    Vector2? position,
    this.iconSize,
    this.iconPosition,
    required this.onClick,
    this.progress,
    this.maxStep,
    IButtonType? buttonType,
  }) : super(position: position, size: Vector2.all(60), anchor: Anchor.center) {
    this.buttonType = buttonType ?? NormalButton();
  }

  @override
  FutureOr<void> onLoad() async {
    // final buttonBGSprite = await loadImage(button, size: Vector2.all(55));
    final nullableProgress = (maxStep != null) ? 0.0 : 100.0;
    buttonBGSprite =
        UiButtonBG(radius: 27, progress: progress ?? nullableProgress);
    add(buttonBGSprite);
    final icon = await loadImage(iconAsset);
    icon.size = iconSize ?? Vector2.all(28);
    icon.position = iconPosition ?? Vector2.all(13);
    add(icon);

    if (buttonType is BadgeButton) {
      final button = (buttonType as BadgeButton);
      final badgeImage = await loadImage(
        counterButton,
        position: button.position,
        size: Vector2.all(25),
      );
      add(badgeImage);
      add(
        badgeText = TextComponent(
          text: "${button.badge > 9 ? "9+" : button.badge}",
          position: Vector2(button.position.x + 6, button.position.y + 1),
          textRenderer: TextPaint(
            style: ktButtonTextStyle,
          ),
        ),
      );
    } else if (buttonType is ExtraBottomButton) {
      final button = (buttonType as ExtraBottomButton);

      //
      final badgeImage = await loadImage(priseButton,
          position: button.position, size: Vector2(66, 24));
      add(badgeImage);

      //
      final buttonXPosition = (button.imageAsset != null)
          ? button.position.x + 24
          : button.position.x + 15;

      if ((button.imageAsset != null)) {
        final badgeImage = await loadImage(
          button.imageAsset!,
          size: button.imageSize ?? Vector2(22, 20),
          position: button.imagePosition != null
              ? Vector2(
                  button.imagePosition!.x,
                  button.position.y + button.imagePosition!.y,
                )
              : Vector2(button.position.x, button.position.y + 2),
        );
        add(badgeImage);
      }

      add(
        TextComponent(
          text: button.text.toString(),
          size: Vector2(66, 24),
          position: button.imagePosition != null
              ? Vector2(
                  button.imagePosition!.x + 2 + (button.imageSize?.x ?? 22),
                  button.position.y + button.imagePosition!.y,
                )
              : Vector2(buttonXPosition, button.position.y),
          textRenderer: TextPaint(
            style: ktButtonTextStyle.copyWith(
              fontSize: button.text.length > 4 ? 12 : 18,
            ),
          ),
        ),
      );
    }
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (buttonType is BadgeButton) {
      badgeText?.text = (buttonType as BadgeButton).badge.toString();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    onClick();
    if (maxStep != null) {
      final step = MAX_PERCENTAGE / maxStep!;
      buttonBGSprite.progress = buttonBGSprite.progress + step;
    }
    super.onTapDown(event);
  }
}

class ImageButton extends SpriteComponent with TapCallbacks {
  String imageAsset;
  final void Function() onClick;

  ImageButton({
    required this.imageAsset,
    required this.onClick,
    Vector2? position,
    Vector2? size,
  }) : super(
            position: position,
            size: size ?? Vector2.all(60),
            anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    final buttonBg = await loadImage(
      imageAsset,
    );
    sprite = buttonBg.sprite;
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    onClick();
    super.onTapDown(event);
  }
}

class IconButton extends SpriteComponent with TapCallbacks {
  String imageAsset;
  final void Function() onClick;
  String iconAsset;
  final Vector2? iconSize;
  final Vector2? iconPosition;

  IconButton({
    required this.imageAsset,
    required this.iconAsset,
    required this.onClick,
    this.iconSize,
    Vector2? position,
    this.iconPosition,
    Vector2? size,
  }) : super(
          position: position,
          size: size ?? Vector2.all(60),
          anchor: Anchor.center,
        );

  @override
  FutureOr<void> onLoad() async {
    final buttonBg = await loadImage(
      imageAsset,
    );
    sprite = buttonBg.sprite;
    final icon = await loadImage(iconAsset,
        size: iconSize ?? Vector2.all(25), position: iconPosition ?? size / 4);
    add(icon);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    onClick();
    super.onTapDown(event);
  }
}

class UiButtonBG extends PositionComponent {
  final double radius;

  double progress;

  UiButtonBG(
      {required this.radius, Vector2? position, this.progress = MAX_PERCENTAGE})
      : super(position: position, size: Vector2.all(radius * 2));

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final rOffset = Offset(radius, radius);

    final rect = Rect.fromCircle(center: rOffset, radius: radius);
    const gradient = RadialGradient(
      colors: [kcGreyLight, kcGreyDark],
    );
    //
    final paint = Paint()..shader = gradient.createShader(rect);
    final blackBorder = Paint()..color = Colors.black;
    final redArcPaint = Paint()..color = kcRed;
    final greyBorder = Paint()..color = kcGreyDark;
    //
    canvas.drawCircle(rOffset, radius + 3.6, greyBorder);
    //
    if (progress > 0) {
      const startAngle = -math.pi * 1.5;
      // Calculate sweep angle to grow from center to right as progress increases
      final sweepAngle = (progress / MAX_PERCENTAGE) *
          math.pi *
          2; // Half-circle based on progress
      //
      // Calculate sweep angle based on progress
      canvas.drawArc(
        Rect.fromCircle(center: rOffset, radius: radius + 3),
        startAngle,
        sweepAngle,
        true,
        redArcPaint,
      );
    }
    canvas.drawCircle(rOffset, radius - 0.6, blackBorder);
    canvas.drawCircle(rOffset, radius - 1, paint);
  }
}
