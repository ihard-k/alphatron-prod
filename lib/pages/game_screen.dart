import 'package:flutter/material.dart';

import 'package:flame/game.dart';

import '../game/my_game.dart';
import 'overlay/celebration_overlay.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MyGame(
          correctWordsSet: {
            'art', 'rat', 'son', 'net', 'sit', 'oil', // 3-letter words
            'star', 'salt', 'loan', 'soil', 'tail',
            'stone', 'saint', // 5-letter words
            'sailor', 'listen', 'relation', 'RELATIONS' // 6-letter words
          }.map((e) => e.toUpperCase()).toSet(),
          shuffledCharacters: "AERTSLNIOM".toUpperCase(),
        ),
        overlayBuilderMap: {
          'CelebrationScreen': (BuildContext context, MyGame game) {
            return const CelebrationScreen();
          },
        },
      ),
    );
  }
}
