import 'package:alphatron/pages/game_screen.dart';
import 'package:alphatron/pages/leaderboard_screen.dart';
import 'package:alphatron/services/alpha_service.dart';
import 'package:flame/flame.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// import 'constants/game_const.dart';
// import 'pages/game_screen.dart';
// import 'pages/round_length_screen.dart';
import 'pages/splash_screen.dart';

// Make sure this file defines kcBgColor
void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();
  await dotenv.load();
  //
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlphaService.instance),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      // home: const LeaderBoardScreen(),
      home: const GameScreen(),
    );
  }
}
