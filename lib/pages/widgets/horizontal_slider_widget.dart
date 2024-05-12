import 'package:flame/image_composition.dart';
import 'package:flutter/material.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

import '../../constants/images.dart';

class HorizontalSliderWidget extends StatefulWidget {
  const HorizontalSliderWidget({
    super.key,
    required this.min,
    required this.max,
    this.maxBtn = false,
  });
  final double min;
  final double max;
  final bool maxBtn;

  @override
  State<HorizontalSliderWidget> createState() => _HorizontalSliderWidgetState();
}

class _HorizontalSliderWidgetState extends State<HorizontalSliderWidget> {
  var _lowerValue = 0.0;
  var _upperValue = 0.0;

  @override
  void initState() {
    _lowerValue = widget.min + 1;
    _upperValue = widget.max - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RangeSliderFlutter(
          values: [_lowerValue, _upperValue],
          max: widget.max,
          min: widget.min,
          rangeSlider: widget.maxBtn,
          handler: RangeSliderFlutterHandler(
            transform: Matrix4.translation(Vector3(-15, 0, 0)),
            child: Text(
              _lowerValue.toStringAsFixed(0),
              style: const TextStyle(
                fontFamily: 'Portico',
                color: Colors.black,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(silverBg2),
              ),
            ),
          ),
          rightHandler: RangeSliderFlutterHandler(
            transform: Matrix4.translation(Vector3(-15, 0, 0)),
            child: Text(
              _upperValue.toStringAsFixed(0),
              style: const TextStyle(
                fontFamily: 'Portico',
                color: Colors.black,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(silverBg1),
              ),
            ),
          ),
          trackBar: RangeSliderFlutterTrackBar(
            activeTrackBarHeight: 10,
            inactiveTrackBarHeight: 12,
            activeTrackBar: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              gradient: LinearGradient(
                colors: [Colors.red, Colors.red.shade800],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            inactiveTrackBar: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(hrSliderBg),
              ),
            ),
          ),
          tooltip: RangeSliderFlutterTooltip(
            custom: (value) => const SizedBox(
              height: 1,
              width: 1,
            ),
            alwaysShowTooltip: false,
          ),
          onDragging: (handlerIndex, lowerValue, upperValue) {
            _lowerValue = lowerValue;
            _upperValue = upperValue;
            setState(() {});
          },
        ),
        Positioned(
          bottom: 0,
          left: 10,
          child: Text(
            widget.min.toStringAsFixed(0),
            style: const TextStyle(
              // fontSize: 12,
              fontFamily: 'Portico',
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: Text(
            widget.max.toStringAsFixed(0),
            style: const TextStyle(
              // fontSize: 12,
              fontFamily: 'Portico',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
