import 'package:alphatron/constants/theme.dart';

import '../constants/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utils/size_config.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String activeButton = ssingleplayer;
  String leftButton = ai;
  String rightButton = steam;
  String selectedButton = 'Solo';
  String activeMode = 'medium';
  //
  List avatar = [
    slide1,
    slide2,
    slide3,
    slide4,
    slide5,
    slide6,
    slide7,
    slide8,
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(rgisterBG),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                const Gap(50),
                Image.asset(
                  regiTitle,
                  width: SizeConfig.screenWidth * 0.6,
                ),
                const Gap(20),
                Image.asset(
                  uniqueName,
                  width: SizeConfig.screenWidth * 0.6,
                ),
                const Gap(8),
                Container(
                  width: SizeConfig.screenWidth * 0.75,
                  height: SizeConfig.screenHeight * 0.05,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        nameHere,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 16,
                    ),
                    child: TextFormField(
                      style: ktPorticoWhite, // Setting text color to white
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your text here', // Placeholder text
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ), // Placeholder text color
                      ),
                    ),
                  ),
                ),
                const Gap(20),
                Image.asset(
                  yourAvtar,
                  width: SizeConfig.screenWidth * 0.5,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.2,
                  width: SizeConfig.screenWidth * 0.6,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: avatar
                        .map(
                          (e) => Image.asset(
                            e,
                            width: SizeConfig.screenWidth * 0.3,
                            fit: BoxFit.contain,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Image.asset(
                  difficultyMode,
                  width: SizeConfig.screenWidth * 0.6,
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ModeButtonWidget(
                      // backgroungImage: easyPlaceholder,
                      title: easy,
                      activeMode: activeMode == 'easy',
                      onTap: (() {
                        setState(
                          () {
                            selectedButton = 'easy';
                            activeMode = 'easy';
                          },
                        );
                      }),
                    ),
                    ModeButtonWidget(
                      // backgroungImage: pressedPlaceholder,
                      title: medium,
                      activeMode: activeMode == 'medium',
                      onTap: (() {
                        setState(
                          () {
                            selectedButton = 'medium';
                            activeMode = 'medium';
                          },
                        );
                      }),
                    ),
                    ModeButtonWidget(
                      // backgroungImage: easyPlaceholder,
                      title: hard,
                      activeMode: activeMode == 'hard',
                      onTap: (() {
                        setState(
                          () {
                            selectedButton = 'hard';
                            activeMode = 'hard';
                          },
                        );
                      }),
                    ),
                  ],
                ),
                const Gap(20),
                Image.asset(
                  connect,
                  width: SizeConfig.screenWidth * 0.3,
                ),
                const Gap(5),
                Image.asset(
                  freeReward,
                  width: SizeConfig.screenWidth * 0.5,
                ),
                const Gap(5),
                const SocialLoginButton(
                  backgroundImage: fbBg,
                  socialLogo: fbLogo,
                  socialTitle: fbTitle,
                ),
                const SocialLoginButton(
                  backgroundImage: googleBg,
                  socialLogo: googlLogo,
                  socialTitle: googleTitle,
                ),
                const Gap(20),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 15,
                      vertical: SizeConfig.safeBlockVertical * 2),
                  // height: SizeConfig.screenHeight * 0.07,
                  //   width: SizeConfig.screenWidth * 0.5,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(saveBtnBg),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Image.asset(
                    save,
                    width: SizeConfig.screenWidth * 0.18,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 15,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.asset(
                  bexit,
                  height: 25,
                  width: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModeButtonWidget extends StatelessWidget {
  const ModeButtonWidget({
    super.key,
    this.backgroungImage,
    required this.title,
    required this.activeMode,
    this.onTap,
  });
  final String? backgroungImage;
  final String title;
  final bool activeMode;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 5,
          vertical: SizeConfig.safeBlockVertical * 2.3,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage(activeMode ? pressedPlaceholder : easyPlaceholder),
            fit: BoxFit.fill,
          ),
        ),
        child: Image.asset(
          title,
          width: SizeConfig.screenWidth * 0.17,
          height: SizeConfig.screenHeight * 0.02,
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.backgroundImage,
    required this.socialLogo,
    required this.socialTitle,
  });
  final String backgroundImage;
  final String socialLogo;
  final String socialTitle;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.safeBlockHorizontal * 5,
              vertical: SizeConfig.safeBlockVertical * 1.5),
          width: SizeConfig.screenWidth * 0.75,
          height: SizeConfig.screenHeight * 0.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.contain,
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                socialLogo,
                height: SizeConfig.screenHeight * 0.05,
              ),
              const Gap(8),
              Expanded(
                child: Image.asset(
                  socialTitle,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(7),
            height: 25,
            width: 30,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(giftBtn),
              ),
            ),
            child: Image.asset(
              sgift,
            ),
          ),
        )
      ],
    );
  }
}
