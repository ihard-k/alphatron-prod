import 'dart:async';

import 'package:flame/game.dart';
import 'package:game_framework/game_framework.dart';
import '../constants/game_const.dart';
import 'components/components.dart';

class WordGame extends FlameGame with HasCollisionDetection {
  String lastWord = "";

  int _score = 0;

  String get lastWordInLowerCase => lastWord.toLowerCase();

  int get score => _score;

  final String _shuffledCharacters;
  final Set<String> _correctWordsSet;

  late LetterBoardComponent letterBoardComp;
  late EyeButton buttonEye;
  Set<String> get correctWordsSet => _correctWordsSet;
  Set<String> get correctGuessedWordsSet => _correctGuessedWordsSet;

  bool isEyeOn = false;
  bool isMysteryOn = false;
  bool isStarOn = false;
  GameModel? gameModel;
  GameController? gameController;

  late WordLayoutComponent _wordLayoutComponent;
  late BigCircleComponent bigCircleComp;
  //
  WordGame({
    required String shuffledCharacters,
    required Set<String> correctWordsSet,
    required this.gameModel,
    this.gameController,
  })  : _correctWordsSet = correctWordsSet,
        _shuffledCharacters = shuffledCharacters;

  Set<String> _correctGuessedWordsSet = {};

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _addWordLayoutComponent();
    _addBigCircleComponent();
    _addLetterBoardComponent();
    _addButtonUi();
    // camera.viewport = FixedResolutionViewport(resolution: Vector2(899, 420));
  }

  @override
  void update(double dt) {
    letterBoardComp.text = lastWord;
    super.update(dt);

    if (_correctGuessedWordsSet.length == _correctWordsSet.length) {
      _correctGuessedWordsSet = {};
      if (gameController is SoloGameController) {
        (gameController as SoloGameController).startRoundCountdown();
        pauseEngine();
      }
    }
    if (_correctWordsSet.contains(lastWordInLowerCase) &&
        !_correctGuessedWordsSet.contains(lastWordInLowerCase) &&
        !bigCircleComp.isDragging) {
      _correctGuessedWordsSet.add(lastWordInLowerCase);
      if (gameModel != null) {
        (gameController)
            ?.makeGuess(gameModel!.getLocalPlayer(), lastWordInLowerCase);
      }
      _score += (lastWordInLowerCase.length * 10);
      letterBoardComp.score(100, lastWordInLowerCase);
      children
          .firstWhere((element) => element is WordLayoutComponent)
          .children
          .whereType<WordComponent>()
          .firstWhere((element) => element.word == lastWordInLowerCase)
          .show(true);
    }
  }

  _addWordLayoutComponent() {
    _wordLayoutComponent = WordLayoutComponent();
    add(_wordLayoutComponent);
  }

  FutureOr<void> _addBigCircleComponent() {
    bigCircleComp = BigCircleComponent(
      characterString: _shuffledCharacters,
    );

    return add(
      bigCircleComp,
    );
  }

  void _addLetterBoardComponent() {
    add(letterBoardComp = LetterBoardComponent());
  }

  void _addButtonUi() async {
    // ShuffleIcon
    final buttonShuffle = ShuffleButton(
      onClick: bigCircleComp.shuffle,
      position: Vector2(40, canvasSize.y - 220),
    );
    add(buttonShuffle);

    buttonEye = EyeButton(
      onClick: () {
        isStarOn = false;
        isMysteryOn = false;
        isEyeOn = !isEyeOn;
      },
      position: Vector2(canvasSize.x - 40, canvasSize.y - 220),
    );

    add(buttonEye);

    final buttonStar = StarButton(
      position: Vector2(40, canvasSize.y - 135),
      onClick: () {
        isStarOn = !isStarOn;
        isMysteryOn = false;
        isEyeOn = false;
      },
    );
    add(buttonStar);

    final buttonQuestion = MysteryButton(
      onClick: () {
        isMysteryOn = !isMysteryOn;
        isStarOn = false;
        isEyeOn = false;
      },
      position: Vector2(canvasSize.x - 40, canvasSize.y - 140),
    );
    add(buttonQuestion);

    final buttonPresent = GiftButton(
      onClick: () {},
      position: Vector2(canvasSize.x - 40, canvasSize.y - 45),
    );
    add(buttonPresent);

    final buttonDictionary = BonusButton(
      onClick: () {
        overlays.add(ksBonusWordsOverlay);
        // overlays.add(ksDictionaryOverlay);
      },
      maxStep: 5,
      position: Vector2(40, canvasSize.y - 35),
    );
    add(buttonDictionary);
  }

  void clearPowerUp() {
    isMysteryOn = false;
    isStarOn = false;
    isEyeOn = false;
  }



  void callMystery(String character) {
    if (isMysteryOn) {
      final letters = children
          .firstWhere((element) => element is WordLayoutComponent)
          .children
          .whereType<WordComponent>()
          .map((e) => e.children
              .whereType<LetterComponent>()
              .where((element) => element.character == character))
          .reduce(
            (value, element) => [...value, ...element],
          )
          .toList();

      for (var child in letters) {
        child.setVisible(true);
      }
      clearPowerUp();
    }
  }
}
