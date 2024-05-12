import 'dart:async';

import 'package:alphatron/pages/game_screen.dart';
import 'package:alphatron/pages/register_screen.dart';
import 'package:alphatron/pages/round_length_screen.dart';
import 'package:alphatron/services/alpha_service.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import '../utils/size_config.dart';
import 'leaderboard_screen.dart';
import '../constants/images.dart';
import 'select_game_dialog_screen.dart';
import 'widgets/coins_widget.dart';

class StartScreens extends StatefulWidget {
  const StartScreens({super.key});

  @override
  State<StartScreens> createState() => _StartScreensState();
}

class _StartScreensState extends State<StartScreens> {
  bool _isPressed = false;

  bool isLeftContainerMoved = false;
  bool isRightContainerMoved = false;

  String activeButton = ssingleplayer;
  String leftButton = ai;
  String rightButton = steam;
  String selectedButton = 'Solo';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Container(
        // height: SizeConfig.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(sbg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TopBar(),
            Expanded(
              child: SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                child: Stack(
                  alignment: Alignment.center,
                  // fit: StackFit.expand,
                  children: [
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 80,
                      child: Image.asset(
                        topplay,
                        width: SizeConfig.screenWidth * 0.5,
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 17,
                      child: Image.asset(
                        bottomplay,
                        width: SizeConfig.screenWidth * 0.5,
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 110,
                      child: Image.asset(
                        buttonbg1,
                        width: SizeConfig.screenWidth * 0.19,
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 83,
                      child: Container(
                        height: 180,
                        width: SizeConfig.screenWidth * 0.45,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(verticle2),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Gap(5),
                            ModeIconButton(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      const RoundLengthDialogBox(),
                                );
                              },
                              icon: ssettings,
                              paddingAll: SizeConfig.safeBlockVertical * 1,
                              iconWidth: SizeConfig.screenWidth * 0.13,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Image.asset(
                        buttonbg2,
                        width: SizeConfig.screenWidth * 0.19,
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      bottom: isLeftContainerMoved || isRightContainerMoved
                          ? SizeConfig.blockSizeVertical * 17
                          : SizeConfig.blockSizeVertical * 2,
                      child: Container(
                        height: 180,
                        width: SizeConfig.screenWidth * 0.45,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(verticle2),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Image.asset(
                            //   singleplyerword,
                            //   width: SizeConfig.screenWidth * 0.11,
                            // ),
                            GradientText(
                              text: selectedButton == 'ai'
                                  ? 'Ai'
                                  : selectedButton == 'team'
                                      ? 'Online'
                                      : "Solo",
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.red.shade100,
                                ],
                                stops: const [0.4, 0.9],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              style: TextStyle(
                                height: 1,
                                color: Colors.white,
                                fontFamily: 'Portico',
                                fontSize: SizeConfig.safeBlockHorizontal * 3,
                              ),
                            ),
                            GradientText(
                              text: "Play",
                              gradient: LinearGradient(
                                colors:
                                    //  player['position'] == "3"
                                    //     ?
                                    [
                                  Colors.white,
                                  Colors.red.shade300,
                                  // Color.fromARGB(255, 172, 5, 5)
                                ],
                                // : [Colors.white, Colors.white38],
                                stops: const [0.5, 0.9],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              style: TextStyle(
                                height: 1,
                                color: Colors.white,
                                fontFamily: 'Portico',
                                fontSize: SizeConfig.safeBlockHorizontal * 3,
                              ),
                            ),
                            const Gap(20),
                            ModeIconButton(
                              icon: activeButton,
                              paddingAll: SizeConfig.safeBlockVertical * 1,
                              iconWidth: SizeConfig.screenWidth * 0.13,
                            ),
                            const Gap(5),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 25,
                      left: SizeConfig.safeBlockHorizontal * 12,
                      child: Transform.rotate(
                        angle: -math.pi / -3.5,
                        child: Image.asset(
                          buttonbg2,
                          width: SizeConfig.screenWidth * 0.18,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      bottom: isLeftContainerMoved
                          ? SizeConfig.safeBlockHorizontal * 37
                          : SizeConfig.safeBlockHorizontal * 23,
                      left: isLeftContainerMoved
                          ? SizeConfig.safeBlockHorizontal * 27
                          : SizeConfig.safeBlockHorizontal * 13,
                      child: Transform.rotate(
                        angle: -math.pi / -3.5,
                        child: Container(
                          height: 180,
                          width: SizeConfig.screenWidth * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(verticle2),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.rotate(
                                angle: -math.pi / 3.5,
                                child: ModeIconButton(
                                  onTap: () {
                                    setState(() {
                                      isLeftContainerMoved =
                                          !isLeftContainerMoved;

                                      if (isLeftContainerMoved) {
                                        // Start a timer to revert isContainerMoved after 2 seconds
                                        var temp = activeButton;
                                        Timer(const Duration(seconds: 1), () {
                                          setState(() {
                                            activeButton = leftButton;
                                            leftButton = temp;
                                            selectedButton = activeButton
                                                .split('/')
                                                .last
                                                .split('.')
                                                .first;
                                            isLeftContainerMoved =
                                                !isLeftContainerMoved;
                                          });
                                        });
                                      }
                                    });
                                  },
                                  icon: leftButton,
                                  // icon: activeButton == 'left'
                                  //     ? ssingleplayer
                                  //     : ai,
                                  paddingAll: SizeConfig.safeBlockVertical * 1,
                                  iconWidth: SizeConfig.screenWidth * 0.13,
                                ),
                              ),
                              const Gap(5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 25,
                      right: SizeConfig.safeBlockHorizontal * 12,
                      child: Transform.rotate(
                        angle: -math.pi / 3.5,
                        child: Image.asset(
                          buttonbg2,
                          width: SizeConfig.screenWidth * 0.18,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      bottom: isRightContainerMoved
                          ? SizeConfig.safeBlockHorizontal * 37
                          : SizeConfig.safeBlockHorizontal * 23,
                      right: isRightContainerMoved
                          ? SizeConfig.safeBlockHorizontal * 27
                          : SizeConfig.safeBlockHorizontal * 13,
                      child: Transform.rotate(
                        angle: -math.pi / 3.5,
                        child: Container(
                          height: 180,
                          width: SizeConfig.screenWidth * 0.4,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(verticle2),
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Transform.rotate(
                                angle: -math.pi / -3.5,
                                child: ModeIconButton(
                                  icon: rightButton,
                                  // icon: activeButton == 'right'
                                  //     ? ssingleplayer
                                  //     : steam,
                                  paddingAll: SizeConfig.safeBlockVertical * 1,
                                  iconWidth: SizeConfig.screenWidth * 0.13,
                                  onTap: () {
                                    setState(() {
                                      isRightContainerMoved =
                                          !isRightContainerMoved;
                                      if (isRightContainerMoved) {
                                        var temp = activeButton;
                                        Timer(const Duration(seconds: 1), () {
                                          setState(() {
                                            activeButton = rightButton;
                                            rightButton = temp;

                                            selectedButton = activeButton
                                                .split('/')
                                                .last
                                                .split('.')
                                                .first;
                                            isRightContainerMoved =
                                                !isRightContainerMoved;
                                          });
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Gap(5)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: SizeConfig.safeBlockHorizontal * 35,
                      child: Container(
                        padding:
                            EdgeInsets.all(SizeConfig.safeBlockHorizontal * 9),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(playbuttonbg),
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              _isPressed = true;
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _isPressed = false;
                            });
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                GameType gameType = GameType.solo;

                                if (selectedButton == "ai") {
                                  gameType = GameType.ai;
                                }
                                if (selectedButton == "solo") {
                                  gameType = GameType.solo;
                                }

                                if (selectedButton == "team") {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const SelectGameDialogBox(),
                                  );
                                  return;
                                }

                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GameScreen(gameType: gameType),
                                  ),
                                  (route) => false,
                                );
                              },
                            );
                          },
                          onTapCancel: () {
                            setState(() {
                              _isPressed = false;
                            });
                          },
                          child: Transform.scale(
                            scale: _isPressed ? 0.9 : 1.0,
                            child: Image.asset(
                              splay, // Replace 'button_image.png' with your image asset
                              width: SizeConfig.screenWidth * 0.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const BottomBar()
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight * 0.16,
      width: SizeConfig.screenWidth,
      child: Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.13,
            width: SizeConfig.screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(top),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockHorizontal * 1,
                  bottom: SizeConfig.safeBlockHorizontal * 7,
                ),
                width: SizeConfig.screenWidth * 0.85,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(topbar),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "HIGH SCORE",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Portico',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.safeBlockHorizontal * 2,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "12795",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Portico',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "MAX ROUND",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Portico',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.safeBlockHorizontal * 2,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      "156",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Portico',
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  // color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const RegisterScreen(),
                            );
                          },
                          child: Image.asset(sProfile)),
                      const Gap(30),
                      BottomMenuButton(
                        icon: setting,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const GameSettingsPage(),
                          ),
                        ),
                        paddingAll: SizeConfig.safeBlockHorizontal * 2.5,
                        iconWidth: SizeConfig.screenWidth * 0.065,
                      ),
                      const Gap(35),
                      const CoinsWidget(),
                    ],
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.18,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(bottom),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BottomMenuButton(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ShopPage(),
                    ),
                  ),
                  icon: sshop,
                  paddingAll: SizeConfig.safeBlockHorizontal * 4.8,
                  iconWidth: SizeConfig.screenWidth * 0.09,
                ),
                BottomMenuButton(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GiftPage(),
                    ),
                  ),
                  icon: sgift,
                  paddingAll: SizeConfig.safeBlockHorizontal * 4.8,
                  iconWidth: SizeConfig.screenWidth * 0.09,
                ),
                BottomMenuButton(
                  icon: strophy,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TopLeaderBoardPage(),
                    ),
                  ),
                  paddingAll: SizeConfig.safeBlockHorizontal * 4.8,
                  iconWidth: SizeConfig.screenWidth * 0.09,
                ),
                BottomMenuButton(
                  icon: sidea,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SuggestionPage(),
                    ),
                  ),
                  paddingAll: SizeConfig.safeBlockHorizontal * 4.8,
                  iconWidth: SizeConfig.screenWidth * 0.09,
                ),
              ],
            ),
          ),
          Image.asset(
            addbanner,
            width: SizeConfig.screenWidth,
          )
        ],
      ),
    );
  }
}

class BottomMenuButton extends StatefulWidget {
  final String icon;
  final double paddingAll;
  final double iconWidth;
  final Function()? onTap;
  const BottomMenuButton(
      {super.key,
      required this.icon,
      required this.paddingAll,
      required this.iconWidth,
      this.onTap});

  @override
  State<BottomMenuButton> createState() => _BottomMenuButtonState();
}

class _BottomMenuButtonState extends State<BottomMenuButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Transform.scale(
        scale: _isPressed ? 0.9 : 1.0,
        child: Container(
          padding: EdgeInsets.all(widget.paddingAll),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(redbg1),
              // fit: BoxFit.fill,
            ),
          ),
          child: Container(
            // height: 10,
            margin: const EdgeInsets.only(top: 5),
            // color: Colors.amber,
            child: Image.asset(
              widget.icon,
              fit: BoxFit.contain,
              width: widget.iconWidth,
            ),
          ),
        ),
      ),
    );
  }
}

class ModeIconButton extends StatefulWidget {
  final String icon;
  final double paddingAll;
  final double iconWidth;
  final Function()? onTap;
  const ModeIconButton(
      {super.key,
      required this.icon,
      required this.paddingAll,
      required this.iconWidth,
      this.onTap});

  @override
  State<ModeIconButton> createState() => _ModeIconButtonState();
}

class _ModeIconButtonState extends State<ModeIconButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _isPressed ? 0.9 : 1.0,
      child: Container(
        // color: Colors.amber,
        child: GestureDetector(
          onTap: widget.onTap,
          onTapDown: (_) {
            setState(() {
              _isPressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              _isPressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              _isPressed = false;
            });
          },
          child: Image.asset(
            widget.icon,
            fit: BoxFit.contain,
            width: widget.iconWidth,
          ),
        ),
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("Shop")),
    );
  }
}

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("Gift")),
    );
  }
}

class TopLeaderBoardPage extends StatelessWidget {
  const TopLeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("LeaderBoard")),
    );
  }
}

class SuggestionPage extends StatelessWidget {
  const SuggestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("Sugesstion")),
    );
  }
}

class GameSettingsPage extends StatelessWidget {
  const GameSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("GameSettings")),
    );
  }
}
