import 'dart:async';

import 'package:alphatron/components/game_ui_button.dart';
import 'package:alphatron/components/letter_board_component.dart';
import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/component_helper_funcitons.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'package:alphatron/components/big_circle_components.dart';
import 'package:alphatron/components/word_layout_component.dart';

class MyGame extends FlameGame with HasCollisionDetection, TapDetector {
  String lastWord = "";
  late TextBoxComponent _scoreText;
  int _score = 0;

  final String _suffeledCharacters;

  final Set<String> _correctWordsSet;

  late LetterBoardComponent letterBoardComp;

  Set<String> get correctWordsSet => _correctWordsSet;
  Set<String> get correcGussedtWordsSet => _correctGuessedWordsSet;

  late WordLayoutComponent _wordLayoutComponent;
  late BigCircleComponents bigCircleComp;
  MyGame(
      {required String shuffledCharacters,
      required Set<String> correctWordsSet})
      : _correctWordsSet = correctWordsSet,
        _suffeledCharacters = shuffledCharacters;

  Set<String> _correctGuessedWordsSet = {};

  @override
  Future<void> onLoad() async {
    _addBackground();
    _addScoreText();
    _addWordLayoutComponent();
    _addLetterBoardComponent();
    _addBigCircleComponent();
    _addButtonUi();

    super.onLoad();
  }

  _addWordLayoutComponent() {
    _wordLayoutComponent = WordLayoutComponent(
      screenSize: canvasSize,
    );
    add(_wordLayoutComponent);
  }

  FutureOr<void> _addBigCircleComponent() {
    bigCircleComp = BigCircleComponents(
      characterString: _suffeledCharacters,
    );
    return add(bigCircleComp);
  }

  void refreshWordLayout() {
    remove(_wordLayoutComponent);

    _wordLayoutComponent = WordLayoutComponent(
      screenSize: canvasSize,
    );

    add(_wordLayoutComponent);
  }

  void _addScoreText() {
    _scoreText = TextBoxComponent(
      text:
          "Score:$_score\n\n${_correctGuessedWordsSet.length}/${_correctWordsSet.length}",
      position: Vector2(canvasSize.x / 4, 50),
      align: Anchor.center,
    );
    // add(_scoreText);
  }

  void _addLetterBoardComponent() {
    letterBoardComp = LetterBoardComponent();
    add(letterBoardComp);
  }

  @override
  void update(double dt) {
    letterBoardComp.text = lastWord;
    super.update(dt);

    if (_correctGuessedWordsSet.length == _correctWordsSet.length) {
      refreshWordLayout();
      Future.delayed(const Duration(milliseconds: 500), () {
        pauseEngine();
        overlays.add("CelebrationScreen");
      });
    }
    if (_correctWordsSet.contains(lastWord) &&
        !_correctGuessedWordsSet.contains(lastWord) &&
        !bigCircleComp.isDragging) {
      _correctGuessedWordsSet.add(lastWord);
      _score += (lastWord.length * 10);
      _scoreText.text =
          "Score:$_score\n\n${_correctGuessedWordsSet.length}/${_correctWordsSet.length}";
      refreshWordLayout();
    }
  }

  @override
  void onTap() {
    if (overlays.isActive('CelebrationScreen')) {
      overlays.remove('CelebrationScreen');
      resumeEngine();
      lastWord = "";
      _correctGuessedWordsSet = {};
    }
  }

  void _addBackground() async {
    var bg = await loadImage(gameBg, size: canvasSize, priority: -1);
    add(bg);
  }

  void _addButtonUi() async {
    // ShuffleIcon
    final buttonShuffle = GameUiButton(
      iconAsset: shuffleIcon,
      position: Vector2(canvasSize.x - 40, canvasSize.y - 300),
    );
    add(buttonShuffle);

    final buttonShuffle3 = GameUiButton(
      iconAsset: present,
      position: Vector2(canvasSize.x - 40, canvasSize.y - 140),
    );
    add(buttonShuffle3);

    final buttonGift = GameUiButton(
      iconAsset: question,
      position: Vector2(canvasSize.x - 40, canvasSize.y - 70),
    );
    add(buttonGift);

    final buttonShuffle2 = GameUiButton(
      iconAsset: present,
      position: Vector2(50, canvasSize.y - 300),
    );
    add(buttonShuffle2);

    final buttonGift2 = GameUiButton(
      iconAsset: aZ,
      position: Vector2(50, canvasSize.y - 70),
    );
    add(buttonGift2);

    final buttonGift3 = GameUiButton(
      iconAsset: eye,
      position: Vector2(50, canvasSize.y - 140),
    );
    add(buttonGift3);
  }
}
