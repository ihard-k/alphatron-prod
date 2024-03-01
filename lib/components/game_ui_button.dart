import 'dart:async';

import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/components.dart';

class GameUiButton extends PositionComponent {
  String iconAsset;

  GameUiButton({required this.iconAsset, Vector2? position})
      : super(position: position, size: Vector2.all(60), anchor: Anchor.center);

  @override
  FutureOr<void> onLoad() async {
    final buttonBGSprite = await loadImage(button, size: Vector2.all(55));
    add(buttonBGSprite);
    final icon = await loadImage(iconAsset);
    icon.size = Vector2.all(28);
    icon.position = Vector2.all(13);
    add(icon);
    return super.onLoad();
  }
}
