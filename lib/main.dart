import 'package:alphatron/pages/home_screen.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

// Make sure this file defines kcBgColor

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortraitUpOnly();
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}
