import 'package:flutter/material.dart';

import '../../constants/images.dart';
import '../../constants/theme.dart';
import '../../utils/size_config.dart';

class SelectGameListWidget extends StatelessWidget {
  const SelectGameListWidget({
    super.key,
    required this.title,
    required this.status,
    required this.selected,
  });
  final String title;
  final String status;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig.screenHeight * 0.055,
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),

      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(selected ? whiteShadowBg : hrBorder),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:ktPorticoWhite.copyWith(
              fontSize: 15,
            ),
             
          ),
          Image.asset(
            status == 'active'
                ? greenBg
                : status == 'disabled'
                    ? hrDarkGreyBg
                    : redBg,
            width: SizeConfig.screenWidth * 0.07,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}