import 'dart:async';

import 'package:alphatron/constants/images.dart' as i;
import 'package:alphatron/game/game.dart';
import 'package:alphatron/game/utils/helper_functions.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:flame/components.dart';

class MyTimerComponent extends SpriteComponent with HasGameRef<WordGame> {
  late SpriteComponent arrow;
  void Function()? onComplete;
  MyTimerComponent({required this.duration, super.position, this.onComplete});

  double xPosition = 3; // Max 133
  final double maxXPosition = 133; // Maximum xPosition
  final double duration; // Total duration in seconds to reach MaxXPosition
  double elapsedTime = 0; // Time elapsed since the start
  bool isTimerStopped = false; //

  @override
  FutureOr<void> onLoad() async {
    sprite = (await loadImage(i.timer)).sprite;
    size = Vector2(156, 54);
    // position = Vector2(130, 36);
    // position = Vector2(130, y);
    priority = 120;
    arrow = await loadImage(
      i.arrow.replaceAsset(),
      size: Vector2(20, 35),
      position: Vector2(xPosition, 14),
    );
    anchor = Anchor.center;
    add(arrow);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isTimerStopped) {
      elapsedTime += dt; // Update elapsed time

      if (elapsedTime <= duration) {
        // Calculate new xPosition based on the proportion of time elapsed
        xPosition = 3 + (maxXPosition - 3) * (elapsedTime / duration);
        arrow.position.x = xPosition;
      } else {
        // Correct any overshoot beyond the intended duration
        if (xPosition != maxXPosition) {
          xPosition = maxXPosition;
          arrow.position.x = xPosition;
        }
        // Stop the timer if it's still running
        isTimerStopped = true;

        if (onComplete != null) {
          onComplete!();
        }
        // Implement any actions that need to happen when the timer stops
      }
    }
  }
}
