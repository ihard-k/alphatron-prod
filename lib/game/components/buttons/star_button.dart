import 'package:flame/game.dart';

import '../../../constants/images.dart';
import 'game_ui_button.dart';

class StarButton extends GameUiButton {
  StarButton({required super.onClick, required super.position, int badge = 0})
      : super(
          progress: 100,
          iconAsset: star,
          iconSize: Vector2.all(33),
          iconPosition: Vector2.all(10),
          buttonType: ExtraBottomButton(
            text: "150",
            imageAsset: coin,
          ),
        );
}
