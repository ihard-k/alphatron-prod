import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/components/buttons/game_ui_button.dart';
import 'package:flame/game.dart';

class ShuffleButton extends GameUiButton {
  ShuffleButton({required super.onClick, required super.position})
      : super(
          iconAsset: shuffleIcon,
          progress: 100,
          iconSize: Vector2.all(32),
          iconPosition: Vector2.all(11),
        );
}
