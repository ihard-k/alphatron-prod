import 'dart:math';
import 'dart:ui';

import 'package:alphatron/constants/theme.dart';
import 'package:alphatron/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_direction.dart';
import 'package:marquee_text/marquee_text.dart';

class MarqueeBands extends StatefulWidget {
  final String text;
  final double fontSize;
  final MarqueeBandsController controller;
  const MarqueeBands({
    super.key,
    this.fontSize = 22,
    required this.text,
    required this.controller,
  });

  @override
  State<MarqueeBands> createState() => _MarqueeBandsState();
}

class MarqueeBandsController {
  final Duration? duration;
  _MarqueeBandsState? _state;
  MarqueeBandsController({this.duration});

  void show({String? text, Duration? duration}) =>
      _state?.show(text: text, duration: duration);
}

class _MarqueeBandsState extends State<MarqueeBands> {
  bool showMarquee = false;
  String text = "";

  @override
  void initState() {
    super.initState();
    text = widget.text;
    widget.controller._state = this;
  }

  void show({String? text, Duration? duration}) {
    setState(() {
      this.text = text ?? this.text;
      showMarquee = true;
    });
    Future.delayed(
      duration ?? widget.controller.duration ?? const Duration(seconds: 1),
      () {
        setState(() {
          showMarquee = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showMarquee,
      child: Stack(
        children: [
          Bands(
            text: text,
            fontSize: widget.fontSize,
            angle: 0,
            speed: 50,
            position: SizeConfig.screenHeight / 2.8 - 30,
          ),
        ],
      ),
    );
  }
}

class Bands extends StatelessWidget {
  final double angle;
  final double position;
  final double? fontSize;
  final double? speed;

  final MarqueeDirection? marqueeDirection;

  const Bands({
    super.key,
    required this.text,
    required this.position,
    this.angle = 0,
    this.fontSize,
    this.speed,
    this.marqueeDirection,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -50,
      top: position,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          width: 490,
          decoration: const BoxDecoration(color: Colors.black, boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(1, 1),
              blurRadius: 10,
            ),
          ]),
          child: MarqueeText(
            marqueeDirection: marqueeDirection ?? MarqueeDirection.rtl,
            text: TextSpan(
              text: text,
            ),
            alwaysScroll: true,
            style: ktPerfogramaGreyWithShadow.copyWith(color: Colors.white),
            speed: speed ?? Random().nextInt(50) + 20,
          ),
        ),
      ),
    );
  }
}
