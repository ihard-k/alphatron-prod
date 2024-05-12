import 'package:flame/game.dart';

import '../../../constants/images.dart';
import 'game_ui_button.dart';

class GiftButton extends GameUiButton {
  GiftButton({required super.onClick, required super.position, int badge = 0})
      : super(
          progress: 100,
          iconAsset: present,
          iconSize: Vector2(32, 35),
          iconPosition: Vector2(12, 6),
          buttonType: ExtraBottomButton(
            text: "Watch",
            imageAsset: videoIcon,
            imageSize: Vector2.all(15),
            imagePosition: Vector2(-2, 4),
          ),
        );
}
