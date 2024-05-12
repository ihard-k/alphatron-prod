import 'package:flame/game.dart';

import '../../../constants/images.dart';
import 'game_ui_button.dart';

class MysteryButton extends GameUiButton {
  MysteryButton(
      {required super.onClick, required super.position, int badge = 0})
      : super(
          progress: 100,
          iconAsset: question,
          iconSize: Vector2(22, 28),
          iconPosition: Vector2(18, 12),
          buttonType: ExtraBottomButton(
            text: "150",
            imageAsset: coin,
          ),
        );
}
