import 'package:alphatron/constants/game_const.dart';
import 'package:alphatron/constants/theme.dart';
import 'package:alphatron/game/game.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../pages/leaderboard_screen.dart';
import '../../utils/size_config.dart';
import '../../constants/images.dart';

class BonusWordsDialog extends StatefulWidget {
  final WordGame game;
  const BonusWordsDialog(this.game, {super.key});

  @override
  State<BonusWordsDialog> createState() => _BonusWordsDialogState();
}

class _BonusWordsDialogState extends State<BonusWordsDialog> {
  List words = [
    "AOS",
    "BEOS",
    "SIDE",
    "BRO",
    "BIOS",
    "RIDES",
    "BIS",
    "DRBS",
    "BEROS",
    "DIE",
    "DIES",
    "BIDES",
    "SIB",
    "IDES",
    "IDEAS"
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: SizeConfig.screenHeight,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 2),
        child: Container(
          height: SizeConfig.screenHeight * 0.41,
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 3,
              vertical: SizeConfig.safeBlockHorizontal * 5),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bbonussilverbg),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    bbonuswords,
                    width: SizeConfig.screenWidth * 0.6,
                  ),
                  const Gap(5),
                  Image.asset(
                    bFlash2,
                    width: SizeConfig.screenWidth * 0.7,
                  ),
                  const Gap(5),
                  Image.asset(
                    bBonusWordsGuessed,
                    width: SizeConfig.screenWidth * 0.8,
                  ),
                  const Gap(12),
                  Container(
                    // height: SizeConfig.screenHeight * 0.4,
                    width: SizeConfig.screenWidth,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(fredbg),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Wrap(
                        // runSpacing: 5,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceEvenly,
                        // spacing: 60,
                        children: [
                          ...(words)
                              .map(
                                (data) => BonusWordsWidget(data: data),
                              )
                              .toList()
                        ]),
                  ),
                  const Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        badditionalpoints,
                        width: SizeConfig.screenWidth * 0.4,
                      ),
                      Container(
                        width: SizeConfig.screenWidth * 0.25,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(bSilverButton),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Text(
                          "150",
                          style: ktPorticoLightWhite.copyWith(
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                          ),
                        ),
                      )
                    ],
                  ),
                  // const Gap(5),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(SizeConfig.safeBlockHorizontal * 13),
                      Image.asset(
                        bWordsFound,
                        width: SizeConfig.screenWidth * 0.3,
                      ),
                      GradientText(
                        text: "10%",
                        gradient: kgTextGradient,
                        style: ktPorticoWhite.copyWith(
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    widget.game.overlays.remove(ksBonusWordsOverlay);
                  },
                  child: Image.asset(
                    fexit,
                    width: SizeConfig.screenWidth * 0.05,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BonusWordsWidget extends StatelessWidget {
  final String data;
  const BonusWordsWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: SizeConfig.screenWidth * 0.25,
          child: Row(
            children: [
              Image.asset(
                bStar,
                width: SizeConfig.screenWidth * 0.04,
              ),
              const Gap(5),
              Text(
                data,
                style: ktAgencyFB.copyWith(
                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                  // fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
