import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

import '../../../constants/images.dart';
import '../../utils/helper_functions.dart';

class SwitchImageButton extends PositionComponent with TapCallbacks {
  String iconAsset;
  String? icon2Asset;
  final Vector2? iconSize;
  final Vector2? iconPosition;
  final void Function() onClick;
  late SpriteComponent icon;
  SpriteComponent? icon2;

  bool isActive = true;

  SwitchImageButton({
    required this.iconAsset,
    required this.onClick,
    Vector2? position,
    this.icon2Asset,
    this.iconSize,
    this.iconPosition,
  }) : super(position: position, size: Vector2.all(60), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    //
    final buttonBg = await loadImage(
      buttonSilver,
      size: Vector2.all(70),
      priority: 100,
      anchor: anchor,
      position: size / 2,
    );
    add(buttonBg);
    //
    icon = await loadImage(iconAsset);
    icon.size = iconSize ?? Vector2.all(28);
    icon.position = iconPosition ?? Vector2(20, 16);
    icon.priority = 100;
    add(icon);
    //
    if (icon2Asset != null) {
      icon2 = await loadImage(icon2Asset!);
      icon2!.size = iconSize ?? Vector2.all(28);
      icon2!.position = (iconPosition ?? Vector2(20, 16)) + Vector2(2, 0);
      icon2!.priority = 100;
    }
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (icon2Asset != null && icon2 != null) {
      if (isActive) {
        add(icon2!);
        remove(icon);
      } else {
        add(icon);
        remove(icon2!);
      }
      isActive = !isActive;
    }

    onClick();
    super.onTapDown(event);
  }
}

class PlayPauseButton extends SwitchImageButton {
  PlayPauseButton({required super.onClick, required super.position})
      : super(
          iconAsset: pauseIcon,
          icon2Asset: resumeIcon,
          iconSize: Vector2(20, 30),
        ) {
    priority = 50;
  }
}
