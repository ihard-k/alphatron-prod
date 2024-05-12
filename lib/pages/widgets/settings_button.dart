import 'package:alphatron/constants/images.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 35,
      top: 45,
      child: GestureDetector(
        onTap: () {},
        child: Image.asset(
          kiSettingI.withAssetPath(),
          width: 65,
        ),
      ),
    );
  }
}
