import 'package:alphatron/constants/images.dart';
import 'package:alphatron/constants/theme.dart';
import 'package:alphatron/services/alpha_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HighScoreWidget extends StatelessWidget {
  const HighScoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Transform.translate(
        offset: const Offset(0, -2),
        child: Container(
          width: 300,
          height: 60,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(topBar),
              fit: BoxFit.fitWidth,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ValueListenableProvider<int>.value(
            value: highScoreNotifier,
            child: Text(
              "High Score: ${highScoreNotifier.value}",
              style: ktPorticoWhite.copyWith(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
