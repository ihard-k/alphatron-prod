import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/components/buttons/game_ui_button.dart';
import 'package:flame/game.dart';

class BonusButton extends GameUiButton {
  BonusButton({
    required super.onClick,
    required super.position,
    required super.maxStep,
  }) : super(
            iconAsset: aZ,
            iconSize: Vector2(35, 30),
            iconPosition: Vector2(10, 15));
}
