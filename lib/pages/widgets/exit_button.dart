import 'package:alphatron/constants/images.dart';
import 'package:alphatron/pages/start_scrreen.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 35,
      top: 48,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const StartScreens(),
              ));
        },
        child: Image.asset(
          kiExitI.withAssetPath(),
          width: 62,
        ),
      ),
    );
  }
}
