import 'dart:math';

import 'package:alphatron/pages/game_screen.dart';

import '../constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import '../utils/size_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _bg(),
          _topTriangle(),
          _bottomTriangle(),
          Stack(
            alignment: Alignment.center,
            children: [
              _singlePlayer(),
              _gameSettingVerticleTab(),
              _singlePlayer2(),
              _singleTabVericleTab(),
              Positioned(
                bottom: SizeConfig.blockSizeVertical * 32,
                left: SizeConfig.safeBlockHorizontal * 13,
                child: SvgPicture.asset(
                  singleplayer,
                  width: SizeConfig.screenWidth * 0.20,
                ),
              ),
              _aiButton(),
              Positioned(
                bottom: SizeConfig.blockSizeVertical * 32,
                right: SizeConfig.safeBlockHorizontal * 13,
                child: SvgPicture.asset(
                  singleplayer,
                  width: SizeConfig.screenWidth * 0.20,
                ),
              ),
              _multiplayerButton(),
              // ),
              _bigCircle(),
              _playButton(context),
            ],
          ),
          _topBar(),
          _bottomBar(),
        ],
      ),
    );
  }

  Positioned _bottomBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Stack(
        children: [
          SvgPicture.asset(
            silverbottomtab,
            width: SizeConfig.screenWidth * 1,
          ),
          Container(
            height: SizeConfig.screenHeight * 0.12,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.safeBlockHorizontal * 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  shop,
                  width: SizeConfig.screenWidth * 0.16,
                ),
                SvgPicture.asset(
                  gift,
                  width: SizeConfig.screenWidth * 0.16,
                ),
                SvgPicture.asset(
                  trophy,
                  width: SizeConfig.screenWidth * 0.16,
                ),
                SvgPicture.asset(
                  idea,
                  width: SizeConfig.screenWidth * 0.16,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              youradd,
              width: SizeConfig.screenWidth * 1,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _topBar() {
    return Positioned(
      top: -40,
      left: 0,
      right: 0,
      child: Stack(
        children: [
          SvgPicture.asset(
            silvertoptab,
            width: SizeConfig.screenWidth * 1.55,
          ),
          Positioned(
            bottom: 38,
            left: 0,
            right: 0,
            child: Stack(
              children: [
                Positioned(
                  right: 30,
                  bottom: 5,
                  child: SizedBox(
                    // width: SizeConfig.screenWidth*0.3,
                    // height: SizeConfig.screenHeight*0.06,
                    child: SvgPicture.asset(
                      horizontalsilvertab,
                      height: SizeConfig.screenHeight * 0.06,
                      // width: SizeConfig.screenWidth * 0.5,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.safeBlockHorizontal * 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          SvgPicture.asset(
                            profile,
                            width: SizeConfig.screenWidth * 0.17,
                          ),
                          Positioned(
                            bottom: -2,
                            right: -3,
                            child: SvgPicture.asset(
                              editicon,
                              width: SizeConfig.screenWidth * 0.09,
                            ),
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        settings,
                        width: SizeConfig.screenWidth * 0.13,
                      ),
                      Row(children: [
                        SvgPicture.asset(
                          profile,
                          width: SizeConfig.screenWidth * 0.135,
                        ),
                        const Gap(3),
                        SvgPicture.asset(
                          m156,
                          width: SizeConfig.screenWidth * 0.08,
                        ),
                        const Gap(3),
                        SvgPicture.asset(
                          plus,
                          width: SizeConfig.screenWidth * 0.13,
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  topblacktab,
                  width: SizeConfig.screenWidth * 0.9,
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.safeBlockHorizontal * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        highscore,
                        width: SizeConfig.screenWidth * 0.12,
                      ),
                      const Gap(5),
                      SvgPicture.asset(
                        h12795,
                        width: SizeConfig.screenWidth * 0.15,
                      ),
                      const Gap(5),
                      SvgPicture.asset(
                        maxround,
                        width: SizeConfig.screenWidth * 0.12,
                      ),
                      const Gap(5),
                      SvgPicture.asset(
                        m156,
                        width: SizeConfig.screenWidth * 0.12,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned _playButton(BuildContext context) {
    return Positioned(
      child: GestureDetector(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const GameScreen())),
        child: SizedBox(
          height: SizeConfig.screenHeight * 0.35,
          width: SizeConfig.screenWidth * 0.35,
          child: SvgPicture.asset(
            play,
            // width: SizeConfig.screenWidth * 0.5,
          ),
        ),
      ),
    );
  }

  SvgPicture _bigCircle() {
    return SvgPicture.asset(
      tabunderplay,
      width: SizeConfig.screenWidth * 0.5,
    );
  }

  Positioned _multiplayerButton() {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 32,
      right: SizeConfig.safeBlockHorizontal * 27,
      child: Transform.rotate(
        angle: -math.pi / 4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              verticlesilvertab,
              width: SizeConfig.screenWidth * 0.15,
            ),
            Positioned(
              bottom: 5,
              child: Transform.rotate(
                  angle: -math.pi / -4,
                  child: SvgPicture.asset(
                    team,
                    width: SizeConfig.screenWidth * 0.13,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _aiButton() {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 32,
      left: SizeConfig.safeBlockHorizontal * 27,
      child: Transform.rotate(
        angle: -math.pi / -4,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(
              verticlesilvertab,
              width: SizeConfig.screenWidth * 0.15,
            ),
            Positioned(
              bottom: 5,
              child: Transform.rotate(
                angle: -math.pi / 4,
                child: SvgPicture.asset(
                  aibutton,
                  width: SizeConfig.screenWidth * 0.13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _singleTabVericleTab() {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            verticlesilvertab,
            width: SizeConfig.screenWidth * 0.15,
          ),
          Positioned(
            bottom: 5,
            child: Column(
              children: [
                SvgPicture.asset(
                  playertext,
                  width: SizeConfig.screenWidth * 0.1,
                ),
                const Gap(10),
                SvgPicture.asset(
                  singleuser,
                  width: SizeConfig.screenWidth * 0.13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned _singlePlayer2() {
    return Positioned(
      bottom: SizeConfig.blockSizeVertical * 23,
      child: SvgPicture.asset(
        singleplayer,
        width: SizeConfig.screenWidth * 0.20,
      ),
    );
  }

  Positioned _gameSettingVerticleTab() {
    return Positioned(
      top: SizeConfig.blockSizeVertical * 25,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: pi,
            child: SvgPicture.asset(
              verticlesilvertab,
              width: SizeConfig.screenWidth * 0.15,
            ),
          ),
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              gamesetting,
              width: SizeConfig.screenWidth * 0.13,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _singlePlayer() {
    return Positioned(
      top: SizeConfig.blockSizeVertical * 24.5,
      child: SvgPicture.asset(
        singleplayer,
        width: SizeConfig.screenWidth * 0.20,
      ),
    );
  }

  Align _bottomTriangle() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 200),
        child: SvgPicture.asset(
          bottabtriangle,
          width: SizeConfig.screenWidth * 0.53,
        ),
      ),
    );
  }

  Align _topTriangle() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(bottom: 200),
        child: SvgPicture.asset(
          toptabtriangle,
          width: SizeConfig.screenWidth * 0.53,
        ),
      ),
    );
  }

  SvgPicture _bg() {
    return SvgPicture.asset(
      background,
      fit: BoxFit.cover,
    );
  }
}
