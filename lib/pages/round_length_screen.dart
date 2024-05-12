
import '../constants/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/size_config.dart';
import 'widgets/horizontal_slider_widget.dart';

class RoundLengthDialogBox extends StatefulWidget {
  const RoundLengthDialogBox({super.key});

  @override
  State<RoundLengthDialogBox> createState() => _RoundLengthDialogBoxState();
}

class _RoundLengthDialogBoxState extends State<RoundLengthDialogBox> {
  String activeRoundLength = '1M';
  String activeGameLength = 'yes';
  String activeDifficulty = 'medium';
  String activeWordGuessing = 'list';
  String activeWordLength = 'max';
  String activeFullLength = 'yes';
  double scrollOffset = 0;
  final _controller = ScrollController();

  var roundLength = [
    {"title": "30S", "image": null, "condition": "30S"},
    {"title": "1M", "image": null, "condition": "1M"},
    {"title": "2M", "image": null, "condition": "2M"},
    {"title": "3M", "image": null, "condition": "3M"},
    {"title": "4M", "image": null, "condition": "4M"},
    {"title": "5M", "image": null, "condition": "5M"},
    {"title": null, "image": modelIcon1, "condition": "modelIcon1"},
    {"title": null, "image": modelIcon2, "condition": "modelIcon2"},
  ];

  var difficulty = [
    {"title": "Easy", "condition": "easy"},
    {"title": "Medium", "condition": "medium"},
    {"title": "Hard", "condition": "hard"},
  ];

  var wordStyle = [
    {"title": "List", "condition": "list"},
    {"title": "Crossword", "condition": "crossword"},
    {"title": "Random", "condition": "random"},
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        scrollOffset = _controller.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: SizeConfig.screenHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.black26,
                  padding: const EdgeInsets.all(4),
                  width: 35,
                  height: 35,
                  child: Image.asset(bexit),
                ),
              ),
            ),
            Container(
              height: SizeConfig.screenHeight * 0.85,
              width: SizeConfig.screenWidth,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.safeBlockHorizontal * 3,
                  vertical: SizeConfig.safeBlockHorizontal * 5),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(mainBG),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    // height: SizeConfig.screenHeight * 0.21,
                    width: SizeConfig.screenWidth * 0.43,
                    padding: const EdgeInsets.all(28),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(blackCircleRing),
                      ),
                    ),
                    child: Image.asset(
                      modelSetting,
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Row(
                      children: [
                        const Gap(10),
                        Stack(
                          children: [
                            Container(
                              height: SizeConfig.screenHeight * 0.4,
                              width: SizeConfig.screenWidth * 0.035,
                              // padding: const EdgeInsets.all(28),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(vtScrollBg),
                                ),
                              ),
                            ),
                            Positioned(
                              top: scrollOffset * 0.93,
                              child: GestureDetector(
                                onVerticalDragUpdate: (details) {
                                  setState(() {
                                    // scrollOffset = details.localPosition.dy;
                                    _controller.position
                                        .jumpTo(details.localPosition.dy);
                                  });
                                },
                                child: Image.asset(
                                  width: SizeConfig.screenWidth * 0.035,
                                  vtScrollBtnBg,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _controller,
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.safeBlockHorizontal * 4),
                            child: Column(
                              children: [
                                const Text(
                                  "ROUND LENGTH",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Portico',
                                  ),
                                ),
                                // const Gap(8),
                                Wrap(
                                  children: roundLength
                                      .map(
                                        (e) => ModeButtonWidget(
                                          title: e["title"],
                                          btnImage: e["image"],
                                          btnWidth:
                                              SizeConfig.screenWidth * 0.2,
                                          activeMode: activeRoundLength ==
                                              e["condition"],
                                          onTap: (() => setState(
                                                () => activeRoundLength =
                                                    e["condition"] ?? "",
                                              )),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const Gap(5),
                                const Text(
                                  "GAME LENGTH",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Portico',
                                  ),
                                ),
                                Row(
                                  children: [
                                    ModeButtonWidget(
                                      btnWidth: SizeConfig.screenWidth * 0.35,
                                      title: 'ROUNDS',
                                      activeMode: activeGameLength == 'ROUNDS'
                                          ? true
                                          : false,
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeGameLength = 'ROUNDS';
                                          },
                                        );
                                      }),
                                    ),
                                    const Gap(10),
                                    const Expanded(
                                      child: HorizontalSliderWidget(
                                        min: 5.0,
                                        max: 50.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ModeButtonWidget(
                                      btnWidth: SizeConfig.screenWidth * 0.35,
                                      title: 'TIME',
                                      activeMode: activeGameLength == 'TIME',
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeGameLength = 'TIME';
                                          },
                                        );
                                      }),
                                    ),
                                    const Gap(10),
                                    const Expanded(
                                      child: HorizontalSliderWidget(
                                        min: 5,
                                        max: 60,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    ModeButtonWidget(
                                      btnWidth: SizeConfig.screenWidth * 0.35,
                                      btnImage: modelIcon1,
                                      activeMode: activeGameLength == 'no',
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeGameLength = 'no';
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),

                                const Gap(8),
                                const Text(
                                  "WORD LENGTH",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Portico',
                                  ),
                                ),
                                // const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ModeButtonWidget(
                                      // backgroungImage: easyPlaceholder,
                                      btnWidth: SizeConfig.screenWidth * 0.2,
                                      title: 'MIN',
                                      activeMode: false,
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeWordLength = 'min';
                                          },
                                        );
                                      }),
                                    ),
                                    const Expanded(
                                      child: HorizontalSliderWidget(
                                        min: 3,
                                        max: 10,
                                        maxBtn: true,
                                      ),
                                    ),
                                    ModeButtonWidget(
                                      // backgroungImage: easyPlaceholder,
                                      btnWidth: SizeConfig.screenWidth * 0.2,
                                      title: 'MAX',
                                      activeMode: true,
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeWordLength = 'max';
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                const Text(
                                  "DIFFICULTY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Portico',
                                  ),
                                ),
                                const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: difficulty
                                      .map(
                                        (e) => ModeButtonWidget(
                                          title: e["title"],
                                          btnWidth:
                                              SizeConfig.screenWidth * 0.25,
                                          activeMode: activeDifficulty ==
                                              e["condition"],
                                          onTap: (() => setState(
                                                () {
                                                  activeDifficulty =
                                                      e["condition"] ?? "";
                                                },
                                              )),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const Gap(10),
                                const Text(
                                  "WORD GUESSING",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Portico',
                                  ),
                                ),
                                const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: wordStyle
                                      .map(
                                        (e) => ModeButtonWidget(
                                          title: e["title"],
                                          fontSize: 14,
                                          btnWidth:
                                              SizeConfig.screenWidth * 0.26,
                                          activeMode: activeDifficulty ==
                                              e["condition"],
                                          onTap: (() => setState(
                                                () {
                                                  activeDifficulty =
                                                      e["condition"] ?? "";
                                                },
                                              )),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const Gap(10),
                                const Text(
                                  "FULL LENGTH ANAGRAMS ONLY",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                    fontFamily: 'Portico',
                                  ),
                                ),
                                const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RadioButtonWidget(
                                      title: 'YES',
                                      activeMode: activeFullLength == 'yes',
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeFullLength = "yes";
                                          },
                                        );
                                      }),
                                    ),
                                    const Gap(20),
                                    RadioButtonWidget(
                                      title: 'NO',
                                      activeMode: activeFullLength == 'no',
                                      onTap: (() {
                                        setState(
                                          () {
                                            activeFullLength = "no";
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ModelRedBgBtnWidget(
                        title: 'DEFAULTS',
                      ),
                      ModelRedBgBtnWidget(
                        title: 'SAVE',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioButtonWidget extends StatelessWidget {
  const RadioButtonWidget({
    super.key,
    required this.title,
    required this.activeMode,
    this.onTap,
  });
  final String title;
  final bool activeMode;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              // fontWeight: FontWeight.bold,
              fontFamily: 'Portico',
            ),
          ),
          const Gap(5),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                activeMode ? darkGreyCircleBg : darkGreyCircleRing,
                width: SizeConfig.screenWidth * 0.1,
              ),
              if (activeMode)
                Image.asset(
                  redBg,
                  width: SizeConfig.screenWidth * 0.07,
                  height: SizeConfig.screenWidth * 0.07,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ModelRedBgBtnWidget extends StatelessWidget {
  const ModelRedBgBtnWidget({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:  EdgeInsets.symmetric(
      //     horizontal: SizeConfig.safeBlockHorizontal * 5,
      //     vertical: SizeConfig.safeBlockVertical * 2),
      height: SizeConfig.screenHeight * 0.08,
      width: SizeConfig.screenWidth * 0.4,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(redHrBtnBg),
          fit: BoxFit.fill,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          // fontWeight: FontWeight.bold,
          fontFamily: 'Portico',
        ),
      ),
    );
  }
}

class ModeButtonWidget extends StatelessWidget {
  const ModeButtonWidget(
      {super.key,
      this.backgroungImage,
      this.title,
      required this.activeMode,
      this.onTap,
      this.fontSize,
      this.btnWidth,
      this.btnImage});
  final String? backgroungImage;
  final String? title;
  final bool activeMode;
  final Function()? onTap;
  final double? fontSize;
  final double? btnWidth;
  final String? btnImage;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.symmetric(
        //   horizontal: SizeConfig.safeBlockHorizontal * 5,
        //   vertical: SizeConfig.safeBlockVertical * 1.5,
        // ),
        height: SizeConfig.screenHeight * 0.06,
        width: btnWidth ?? SizeConfig.screenWidth * 0.26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage(activeMode ? pressedPlaceholder : easyPlaceholder),
            fit: BoxFit.fill,
          ),
        ),
        child: btnImage != null
            ? Image.asset(
                btnImage!,
                width: SizeConfig.screenWidth * 0.15,
              )
            : Text(
                '$title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize ?? 18,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Portico',
                ),
              ),
      ),
    );
  }
}
