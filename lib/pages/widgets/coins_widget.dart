import 'package:alphatron/constants/images.dart';
import 'package:alphatron/constants/theme.dart';

import 'package:alphatron/utils/string_extension.dart';
import 'package:flutter/material.dart';

import '../../utils/size_config.dart';
import '../start_scrreen.dart';

class CoinsWidget extends StatelessWidget {
  const CoinsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(coinBg.withAssetPath()),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "999999+",
                    style: ktPorticoWhite.copyWith(fontSize: 18),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: Image.asset(
                  coin.withAssetPath(),
                  height: 36,
                  width: 36,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ShopPage(),
                    ),
                  ),
                  child: const AddCoinsButton(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AddCoinsButton extends StatelessWidget {
  const AddCoinsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomMenuButton(
      icon: iPlus.withAssetPath(),
      paddingAll: 8,
      iconWidth: SizeConfig.screenWidth * 0.065,
    );
  }
}
