import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/components/buttons/game_ui_button.dart';
import 'package:flame/game.dart';
import 'package:flame/src/events/messages/tap_down_event.dart';

class EyeButton extends GameUiButton {
  EyeButton({required super.onClick, required super.position, int badge = 7})
      : super(
          progress: 100,
          iconAsset: eye,
          iconSize: Vector2(35, 28),
          iconPosition: Vector2(10, 12),
          maxStep: badge,
          buttonType: BadgeButton(position: Vector2(35, 35), badge: badge),
        );

  void increment() {
    final bValue = (buttonType as BadgeButton);
    buttonType =
        BadgeButton(position: bValue.position, badge: bValue.badge + 1);
  }

  void decrement() {
    final bValue = (buttonType as BadgeButton);
    print("badge ${bValue.badge}");
    buttonType =
        BadgeButton(position: bValue.position, badge: bValue.badge - 1);
  }

  @override
  void onTapDown(TapDownEvent event) {
    decrement();
    super.onTapDown(event);
  }
}
