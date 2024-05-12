import '../constants/images.dart';
import '../constants/theme.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  List leaderboard = [
    {
      'id': '1',
      'position': '1',
      'name': 'JESSICA',
      'score': '1223456',
      'points': '1.25',
      'posimg': greenupsign,
    },
    {
      'id': '2',
      'position': '2',
      'name': 'JESSICA',
      'score': '1223456',
      'points': '1.24',
      'posimg': greenupsign,
    },
    {
      'id': '3',
      'position': '3',
      'name': 'JESSICA',
      'score': '1223456',
      'points': '1.23',
      'posimg': greenupsign,
    },
    {
      'id': '4',
      'position': 'ABSENT',
      'name': 'JESSICA',
      'score': '1223456',
      'points': '1.22',
      'posimg': reDownSign,
    },
    {
      'id': '5',
      'position': 'X',
      'name': '',
      'score': '',
      'points': '',
      'posimg': reDownSign,
    },
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Center(
        child: Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(lbg),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  const Gap(35),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                    child: Text(
                      "JESSICA WINS!",
                      style: ktPorticoLightWhite.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal * 7,
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight * 0.18,
                    // width: SizeConfig.screenWidth * 0.18,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(wings), fit: BoxFit.contain),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: SizeConfig.screenHeight * 0.12,
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(roundFrame),
                              fit: BoxFit.contain,
                            ),
                          ),
                          //
                        ),
                        Positioned(
                            child: Container(
                          margin: EdgeInsets.only(
                              bottom: SizeConfig.safeBlockHorizontal * 4),
                          // color: Colors.amberAccent,
                          height: SizeConfig.screenHeight * 0.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Gap(15),
                              Text(
                                "ROUND",
                                style: ktPorticoRedWithShadow.copyWith(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 2.5,
                                ),
                              ),
                              const Gap(2),
                              SizedBox(
                                height: SizeConfig.screenHeight * 0.03,
                                child: Text(
                                  "5555",
                                  style: ktPorticoWhiteWithShadow.copyWith(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5.5,
                                  ),
                                ),
                              ),
                              Image.asset(
                                kiRoundFrameElement,
                                width: SizeConfig.screenWidth * 0.15,
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Positioned(
                          top: 0,
                          bottom: 0,
                          child: WinnerNumbering(
                            positionNo: 1,
                            topImg: first,
                            bottomImg: podium1,
                            profile: kilProfile,
                            position: reward,
                          ),
                        ),
                        Positioned(
                          left: SizeConfig.safeBlockHorizontal * 12,
                          bottom: 0,
                          child: const WinnerNumbering(
                            positionNo: 2,
                            topImg: second,
                            bottomImg: podium2,
                            profile: kilProfile,
                            position: reward,
                          ),
                        ),
                        Positioned(
                          right: SizeConfig.safeBlockHorizontal * 14,
                          bottom: 0,
                          child: const WinnerNumbering(
                            positionNo: 3,
                            topImg: third,
                            bottomImg: podium3,
                            profile: kilProfile,
                            position: reward,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Container(
                    // width: SizeConfig.screenWidth,
                    // height: SizeConfig.screenHeight * 0.15,
                    // padding: const EdgeInsets.symmetric(vertical: 10),
                    // alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(kiHighScoreDisplay),
                          fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                              SizeConfig.safeBlockHorizontal * 2),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: SizeConfig.safeBlockHorizontal * 7),
                          child: Text(
                            "GAME OVER",
                            style: ktPerfogramaGreyWithShadow.copyWith(
                              fontSize: SizeConfig.safeBlockHorizontal * 12,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: SizeConfig.safeBlockHorizontal * 4.5,
                          child: Image.asset(
                            leftreddisplay,
                            width: SizeConfig.screenWidth * 0.3,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: SizeConfig.safeBlockHorizontal * 4.5,
                          child: Image.asset(
                            rightreddisplay,
                            width: SizeConfig.screenWidth * 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(5),
                  Container(
                      // width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.28,
                      // padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(leaderbordbg),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...leaderboard.map(
                            (player) => LeaderBoard(
                              player: player,
                            ),
                          ),
                        ],
                      )),
                  const Gap(10),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.safeBlockHorizontal * 1),
                    color: Colors.white60,
                    child: Text(
                      "SPACE  FOR  AD",
                      style: ktPorticoLightWhite.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal * 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 0,
              child: Container(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(lleftbg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Image.asset(
                  kiExit,
                  width: SizeConfig.screenWidth * 0.13,
                ),
              ),
            ),
            Positioned(
              top: 35,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(SizeConfig.safeBlockHorizontal * 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(lrightbg),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Image.asset(
                  next,
                  width: SizeConfig.screenWidth * 0.13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WinnerNumbering extends StatelessWidget {
  final String topImg;
  final String bottomImg;
  final String profile;
  final String position;
  final int positionNo;
  const WinnerNumbering({
    super.key,
    required this.topImg,
    required this.bottomImg,
    required this.profile,
    required this.position,
    required this.positionNo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: positionNo == 1
          ? SizeConfig.screenHeight * 0.2
          : positionNo == 2
              ? SizeConfig.screenHeight * 0.215
              : SizeConfig.screenHeight * 0.2,
      width: positionNo == 1
          ? SizeConfig.screenWidth * 0.23
          : positionNo == 2
              ? SizeConfig.screenWidth * 0.21
              : SizeConfig.screenWidth * 0.19,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(light2),
          opacity: 0.2,
        ),
      ),
      child: Column(
        children: [
          Image.asset(topImg),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: SizeConfig.safeBlockHorizontal * 5,
                  top: 0,
                  width: SizeConfig.screenWidth * 0.14,
                  child: Image.asset(
                    light2,
                    fit: BoxFit.fill,
                    opacity: const AlwaysStoppedAnimation(.4),
                  ),
                ),
                Positioned(
                  bottom: SizeConfig.safeBlockHorizontal * 10,
                  top: 0,
                  width: SizeConfig.screenWidth * 0.08,
                  child: Image.asset(
                    light2,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  bottom: positionNo == 1
                      ? SizeConfig.safeBlockHorizontal * 29
                      : positionNo == 3
                          ? SizeConfig.safeBlockHorizontal * 25
                          : 0,
                  child: Center(
                    child: Image.asset(
                      position,
                      width: SizeConfig.screenWidth * 0.085,
                    ),
                  ),
                ),
                Positioned(
                  bottom: positionNo != 3
                      ? SizeConfig.safeBlockHorizontal * 24
                      : null,
                  left: 0,
                  // right: 0,
                  child: Center(
                    child: Image.asset(
                      position,
                      width:
                          positionNo != 3 ? SizeConfig.screenWidth * 0.085 : 0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: positionNo != 3
                      ? SizeConfig.safeBlockHorizontal * 24
                      : null,
                  right: 0,
                  // right: 0,
                  child: Center(
                    child: Image.asset(
                      position,
                      width:
                          positionNo != 3 ? SizeConfig.screenWidth * 0.085 : 0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: positionNo == 1
                      ? SizeConfig.safeBlockHorizontal * 11
                      : positionNo == 2
                          ? SizeConfig.safeBlockHorizontal * 10
                          : SizeConfig.safeBlockHorizontal * 9,
                  // left: 0,
                  // right: 0,
                  child: Center(
                    child: Image.asset(
                      profile,
                      width: positionNo == 1
                          ? SizeConfig.screenWidth * 0.1
                          : positionNo == 2
                              ? SizeConfig.screenWidth * 0.09
                              : SizeConfig.screenWidth * 0.08,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    bottomImg,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderBoard extends StatelessWidget {
  final dynamic player;
  const LeaderBoard({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // padding: const EdgeInsets.all(15),
          height: SizeConfig.screenHeight * 0.05,
          width: SizeConfig.screenWidth * 0.17,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(smalldisplay),
              fit: BoxFit.fill,
            ),
          ),
          child: Text(
            '${player['position']}',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Portico',
              fontSize: player['position'] == 'ABSENT'
                  ? SizeConfig.safeBlockHorizontal * 2.5
                  : SizeConfig.safeBlockHorizontal * 5,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                // padding: const EdgeInsets.all(15),
                // height: SizeConfig.screenHeight *0.02,
                width: SizeConfig.screenWidth,
                // alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(blackdatatab),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kilProfile,
                      width: SizeConfig.screenWidth * 0.1,
                    ),
                    const Gap(10),
                    Expanded(
                      child: GradientText(
                        text: "${player['name']}",
                        gradient: LinearGradient(
                          colors: player['position'] == "3"
                              ? [
                                  Colors.red,
                                  const Color.fromARGB(255, 172, 5, 5)
                                ]
                              : [Colors.white, Colors.white38],
                          stops: const [0.3, 0.7],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        style: ktPorticoWhite.copyWith(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GradientText(
                        text: "${player['score']}",
                        gradient: LinearGradient(
                          colors: player['position'] == "3"
                              ? [
                                  Colors.red,
                                  const Color.fromARGB(255, 172, 5, 5)
                                ]
                              : [Colors.white, Colors.white38],
                          stops: const [0.3, 0.7],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        style: ktPorticoWhite.copyWith(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                        ),
                      ),
                    ),
                    GradientText(
                      text: "${player['points']}",
                      gradient: LinearGradient(
                        colors: player['position'] == "3"
                            ? [Colors.red, const Color.fromARGB(255, 172, 5, 5)]
                            : [Colors.white, Colors.white38],
                        stops: const [0.3, 0.7],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      style: ktPorticoWhite.copyWith(
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                      ),
                    ),
                    const Gap(5),
                    if (player['position'] != 'X')
                      Image.asset(
                        player['posimg'],
                        width: SizeConfig.screenWidth * 0.04,
                      ),
                    const Gap(15),
                  ],
                ),
              ),
              if (player['position'] == 'ABSENT')
                Positioned(
                  // left: 2,
                  right: 2,
                  child: Image.asset(
                    redFlash,
                    width: SizeConfig.screenWidth,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  const GradientText({
    super.key,
    required this.text,
    required this.gradient,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return (gradient).createShader(bounds);
      },
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
