import 'package:alphatron/constants/game_const.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/game/overlay/bonus_words_dialog.dart';
import 'package:alphatron/game/overlay/dictonary_dialog.dart';
import 'package:alphatron/utils/size_config.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:game_framework/game_framework.dart';

import 'package:flame/game.dart';
import 'package:provider/provider.dart';

import '../game/game.dart';
import '../services/alpha_service.dart';
import 'widgets/coins_widget.dart';
import 'widgets/exit_button.dart';
import 'widgets/high_score_widget.dart';
import 'widgets/robot_widget.dart';
import 'widgets/settings_button.dart';

class GameScreen extends StatefulWidget {
  final GameType gameType;
  const GameScreen({super.key, this.gameType = GameType.solo});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // FROM ALPHATRON
  AlphaService? _alphaService;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(microseconds: 10), () async {
      _alphaService = Provider.of<AlphaService>(context, listen: false);
      await _alphaService?.initAlphatron(gameType: widget.gameType);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: 420, maxHeight: 900, minHeight: 890, minWidth: 420),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // if (gameModel != null)
                  Consumer<AlphaService>(
                    builder: (context, alpha, _) {
                      return GameWidget(
                        backgroundBuilder: (_) => const GameBG(),
                        game: WordGame(
                          correctWordsSet: alpha.correctWordsSet,
                          gameModel: alpha.gameModel,
                          shuffledCharacters: alpha.seedWord.toUpperCase(),
                          gameController: alpha.gameController,
                        ),
                        overlayBuilderMap: {
                          ksDictionaryOverlay:
                              (BuildContext context, WordGame game) =>
                                  DictionaryDialog(game),
                          ksBonusWordsOverlay:
                              (BuildContext context, WordGame game) =>
                                  BonusWordsDialog(game),
                        },
                      );
                    },
                  ),
                  const GameLeaderBoardTopBar(setInitiallyHidden: true),
                ],
              ),
            ),
            Container(
              height: 54,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(kiAdBanner),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GameLeaderBoardTopBar extends StatefulWidget {
  final bool setInitiallyHidden;

  const GameLeaderBoardTopBar({
    this.setInitiallyHidden = false,
    super.key,
  });

  @override
  State<GameLeaderBoardTopBar> createState() => _GameLeaderBoardTopBarState();
}

class _GameLeaderBoardTopBarState extends State<GameLeaderBoardTopBar> {
  bool isHidden = false;
  bool showExtra = false;

  @override
  void initState() {
    isHidden = widget.setInitiallyHidden;
    showExtra = widget.setInitiallyHidden;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => setState(() => isHidden = !isHidden),
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: 110,
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  top: isHidden ? -70 : 0,
                  onEnd: () => setState(() => showExtra = isHidden),
                  child: Image.asset(
                    kiStartTop,
                    height: 100,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.fill,
                  ),
                ),
                if (!isHidden && !showExtra) ...[
                  const Positioned(
                      right: 0, left: 0, top: 60, child: CoinsWidget()),
                  const HighScoreWidget(),
                  const SettingsButton(),
                  const ExitButton(),
                ],
                if (isHidden)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      bottomArrow.withAssetPath(),
                      height: 15,
                      width: 30,
                      fit: BoxFit.fill,
                    ),
                  )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isHidden,
          child: SizedBox(
            width: SizeConfig.screenWidth,
            height: 160,
            child: Consumer<AlphaService>(
              builder: (context, alpha, child) => StreamBuilder<AppEvent>(
                stream: alpha.gameModel?.events,
                builder: (context, snapshot) {
                  if (snapshot.data is PlayerJoinedGameEvent) {
                    print((snapshot.data as PlayerJoinedGameEvent)
                        .player
                        .displayName);
                  }

                  return RobotPositionWidget(
                    alpha: alpha,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RobotPositionWidget extends StatelessWidget {
  final AlphaService alpha;
  const RobotPositionWidget({super.key, required this.alpha});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 40,
          child: Image.asset(
            placeForRobots.withAssetPath(),
            width: SizeConfig.screenWidth,
          ),
        ),
        ...alpha.gameModel?.players
                .map(
                  (e) => AnimatedPositioned(
                    left: (alpha.gameModel?.players.indexOf(e) ?? 0) *
                        SizeConfig.screenWidth /
                        (alpha.gameModel?.players.length ?? 1),
                    duration: const Duration(milliseconds: 300),
                    child: RobotWidget(
                      botColor:
                          botColors[alpha.gameModel?.players.indexOf(e) ?? 0],
                      position: (alpha.gameModel?.players.indexOf(e) ?? 0) + 1,
                      name: e.displayName,
                      score: e.totalGameScore,
                    ),
                  ),
                )
                .toList() ??
            []
      ],
    );
  }
}

class GameBG extends StatelessWidget {
  const GameBG({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: const AssetImage("assets/images/$gameBg"),
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
