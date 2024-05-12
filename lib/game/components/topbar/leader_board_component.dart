import 'dart:async';

import 'package:alphatron/game/components/buttons/game_ui_button.dart';
import 'package:alphatron/game/game.dart';
import 'package:alphatron/game/utils/helper_functions.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:flame/components.dart';

import '../../../constants/images.dart';
import '../../../constants/theme.dart';

class TopLeaderBoardComponent extends PositionComponent
    with HasGameRef<WordGame> {
  //
  @override
  FutureOr<void> onLoad() async {
    //
    final topImage = await loadImage(
      kiStartTop.replaceAsset(),
      size: Vector2(gameRef.canvasSize.x, 100),
    );
    add(topImage);
    //
    final kTopBar = await loadImage(
      topBar.replaceAsset(),
      size: Vector2(gameRef.canvasSize.x - 100, 50),
      position: Vector2(50, 0),
    );
    add(kTopBar);
    //

    final coinBgS = await loadImage(
      coinBg.replaceAsset(),
      size: Vector2(120, 50),
      position: Vector2((gameRef.canvasSize.x / 2) - 55, 60),
    );
    add(coinBgS);

    final coinS = await loadImage(
      coin.replaceAsset(),
      size: Vector2(40, 40),
      position: Vector2((gameRef.canvasSize.x / 2) - 65, 65),
    );
    add(coinS);

    //
    add(
      ImageButton(
        imageAsset: kiSettingI.replaceAsset(),
        position: Vector2(game.canvasSize.x - 75, 80),
        onClick: () {},
      ),
    );

    add(
      ImageButton(
        imageAsset: kiExit.replaceAsset(),
        position: Vector2(75, 80),
        onClick: () {},
      ),
    );

    add(
      TextComponent(
        text: "HighScore: ${game.score}",
        position: Vector2((gameRef.canvasSize.x / 3), 5),
        textRenderer: TextPaint(style: ktButtonTextStyle),
      ),
    );

    add(
      TextComponent(
        text: "5300",
        position: Vector2((gameRef.canvasSize.x / 2) - 20, 75),
        textRenderer: TextPaint(style: ktButtonTextStyle),
      ),
    );

    add(
      IconButton(
        imageAsset: redBg1.replaceAsset(),
        iconAsset: iPlus,
        onClick: () {},
        size: Vector2.all(45),
        position: Vector2((gameRef.canvasSize.x / 2) + 55, 85),
        iconPosition: Vector2(11, 15),
      ),
    );

    super.onLoad();
  }
}
