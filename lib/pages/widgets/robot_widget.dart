import 'dart:math';

import 'package:alphatron/constants/images.dart';
import 'package:alphatron/constants/theme.dart';
import 'package:alphatron/utils/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:game_framework/game_framework.dart';
import 'package:gap/gap.dart';

class RobotWidget extends StatefulWidget {
  final String botColor;
  final String name;
  final int position;
  final int score;
  final int increment;
  final Player? player;

  const RobotWidget({
    super.key,
    required this.position,
    this.player,
    this.botColor = "red",
    required this.name,
    this.increment = 0,
    this.score = 0,
  });

  @override
  State<RobotWidget> createState() => _RobotWidgetState();
}

class _RobotWidgetState extends State<RobotWidget> {
  bool isAngry = false;

  RobotHeadController robotHeadController = RobotHeadController();

  @override
  Widget build(BuildContext context) {
    var isZero = widget.increment == 0;
    var isAngerOrNormal = isAngry ? "red" : widget.botColor;
    return GestureDetector(
      onTap: () {
        setState(() {
          isAngry = !isAngry;
          robotHeadController.rotateHead();
        });
      },
      child: SizedBox(
        height: 160,
        width: 75,
        child: Stack(
          children: [
            Positioned(
              bottom: 40,
              left: 15,
              child: Image.asset(
                botBody,
                width: 45,
                height: 45,
              ),
            ),
            Positioned(
              bottom: 72,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage("$botAssetPath$isAngerOrNormal$botName"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    height: 30,
                    width: 75,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.name,
                          style: ktPorticoLightWhite.copyWith(
                            fontSize: 11,
                            shadows: [
                              const Shadow(
                                  color: Colors.black, offset: Offset(1, 2))
                            ],
                          ),
                        ),
                        const Gap(4),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Gap(20),
                      RotatingHeadSwitcher(
                        firstImagePath:
                            "$botAssetPath${widget.botColor}$botHead",
                        secondImagePath: "${botAssetPath}red$botHead",
                        controller: robotHeadController,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "$botAssetPath${isAngry ? "red" : widget.botColor}$botBall",
                    width: 35,
                    height: 35,
                  ),
                  Text(
                    widget.position.toString(),
                    style: ktPorticoLightWhite.copyWith(
                      fontSize: 18,
                      shadows: [
                        const Shadow(color: Colors.black, offset: Offset(1, 2))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 45,
              right: 20,
              child: Image.asset(
                botArm,
                width: 12,
                height: 12,
              ),
            ),
            Positioned(
              left: 28,
              bottom: 104,
              child: Image.asset(
                "$botAssetPath${isAngry ? "red" : widget.botColor}$botArrow",
                width: 20,
                height: 10,
              ),
            ),
            Positioned(
              bottom: 10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    displayHighScore.withAssetPath(),
                    width: 75,
                    height: 35,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: isZero ? 8 : 13,
                    child: Text(
                      widget.score.toString(),
                      style:
                          ktPorticoWhiteWithBlackShadow.copyWith(fontSize: 14),
                    ),
                  ),
                  if (!isZero)
                    Positioned(
                      bottom: 5,
                      child: Row(
                        children: [
                          Text(
                            widget.increment.toString(),
                            style: ktPorticoWhiteWithBlackShadow.copyWith(
                              fontSize: 10,
                              color: widget.increment.isNegative
                                  ? const Color(0xFFFF130F)
                                  : const Color(0xFF06E60E),
                            ),
                          ),
                          const Gap(2),
                          Image.asset(
                            widget.increment.isNegative
                                ? redDownSign.withAssetPath()
                                : greenUpSign.withAssetPath(),
                            width: 10,
                            height: 6,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RobotHeadController {
  _RotatingHeadSwitcherState? _state;
  Future rotateHead() async => _state?.flipCard();
}

class RotatingHeadSwitcher extends StatefulWidget {
  final String firstImagePath;
  final String secondImagePath;
  final RobotHeadController controller;

  const RotatingHeadSwitcher({
    Key? key,
    required this.firstImagePath,
    required this.secondImagePath,
    required this.controller,
  }) : super(key: key);

  @override
  State<RotatingHeadSwitcher> createState() => _RotatingHeadSwitcherState();
}

class _RotatingHeadSwitcherState extends State<RotatingHeadSwitcher>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      precacheImage(AssetImage(widget.firstImagePath), context);
      precacheImage(AssetImage(widget.secondImagePath), context);
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  flipCard() async {
    isFront = !isFront;
    if (isFront) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        var angle = _controller.value * pi;
        var matrix4 = Matrix4.identity()
          ..setEntry(2, 3, 0.002) // Perspective
          ..rotateY(angle);
        return Transform(
          alignment: Alignment.center,
          transform: matrix4, // Y-axis rotation
          child: isFrontImage(angle.abs())
              ? Image.asset(
                  widget.firstImagePath,
                  width: 35,
                  height: 35,
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: Image.asset(
                    widget.secondImagePath,
                    width: 35,
                    height: 35,
                  ),
                ),
        );
      },
    );
  }

  bool isFrontImage(double angle) {
    const d90 = pi / 2;
    const d270 = 3 * d90;

    return angle <= d90 || angle >= d270;
  }
}

const botColors = ["pink", "blue", "green", "yellow", "cyan"];
