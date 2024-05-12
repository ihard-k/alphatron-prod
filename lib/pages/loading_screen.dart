import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//
import '../constants/images.dart';
import '../utils/size_config.dart';
// import 'start_scrreen.dart';
import 'start_scrreen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  int numberOfRedLights = 0;
  static const int maxRedLights = 12;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  late Timer timer;

  void startTimer() {
    const Duration duration = Duration(milliseconds: 400);

    timer = Timer.periodic(duration, (timer) {
      if (numberOfRedLights < maxRedLights) {
        setState(() {
          numberOfRedLights++;
        });
      } else {
        timer.cancel();

        // numberOfRedLights = 0;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StartScreens()),
        ); // Stop the timer after reaching the maximum number of red lights
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              width: SizeConfig.screenWidth,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(loaderBG), fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    alphatron,
                    width: SizeConfig.screenWidth * 0.7,
                  ),
                  const Gap(10),
                  Image.asset(
                    item1,
                    width: SizeConfig.screenWidth * 0.7,
                  ),
                  const Gap(10),
                  SizedBox(
                    width: SizeConfig.screenWidth,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 0,
                          child: Image.asset(
                            left,
                            width: SizeConfig.screenWidth * 0.2,
                            // fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Image.asset(
                            right,
                            width: SizeConfig.screenWidth * 0.2,
                            // fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          height: SizeConfig.screenHeight * 0.16,
                          width: SizeConfig.screenWidth * 0.85,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 23, vertical: 31),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(displayframe),
                                fit: BoxFit.fill),
                          ),
                          child: Container(
                            // padding: EdgeInsets.symmetric(),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(loadingdisplay),
                                  fit: BoxFit.contain),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                for (int i = 0; i < numberOfRedLights; i++)
                                  Positioned(
                                    top: SizeConfig.safeBlockHorizontal * 2.9,
                                    left: (SizeConfig.safeBlockVertical *
                                            2.35 *
                                            i) +
                                        SizeConfig.safeBlockVertical * 2.5,
                                    // right: SizeConfig.safeBlockHorizontal * 5.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          redlight,
                                          height: SizeConfig.safeBlockVertical *
                                              3.5,
                                          width: SizeConfig.safeBlockVertical *
                                              3.5,
                                        ),
                                        Transform.translate(
                                          offset: Offset(
                                              0,
                                              -SizeConfig.safeBlockVertical *
                                                  1),
                                          child: Image.asset(
                                            redlight,
                                            height:
                                                SizeConfig.safeBlockVertical *
                                                    3.5,
                                            width:
                                                SizeConfig.safeBlockVertical *
                                                    3.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                // for (int i = 0; i < numberOfRedLights; i++)
                                //   Positioned(
                                //     bottom: SizeConfig.safeBlockHorizontal * 3,
                                //     left: SizeConfig.safeBlockHorizontal * 5 +
                                //         (17.9 * i),
                                //     right: SizeConfig.safeBlockHorizontal * 5.5,
                                //     child: Row(
                                //       children: [
                                //         Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Image.asset(
                                //               redlight,
                                //               height:
                                //                   SizeConfig.screenHeight * 0.035,
                                //               width:
                                //                   SizeConfig.screenWidth * 0.07,
                                //             ),

                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Image.asset(
                    loading,
                    width: SizeConfig.screenWidth * 0.4,
                  )
                ],
              ),
            ),
            Positioned(
              top: 26,
              left: 0,
              right: 0,
              child: Container(
                height: SizeConfig.screenHeight * 0.13,
                width: SizeConfig.screenWidth,
                alignment: Alignment.topCenter,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(loadingtop),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Image.asset(
                    AvcGames,
                    width: SizeConfig.screenWidth * 0.5,
                    // fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                loadingbottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
