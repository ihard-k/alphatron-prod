import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';

class AnimatedTextComponent extends TextBoxComponent {
  AnimatedTextComponent({
    super.text,
    super.textRenderer,
    super.boxConfig,
    super.anchor = Anchor.center,
    super.position,
    super.children,
    super.priority = 110,
    bool isScaleAndDisappear = false,
    double scale = 1.0,
    double opacity = 1.0,
    double scaleSpeed = 0.2,
    double opacitySpeed = 0.4,
  });

  void scaleAndDisappear() {
    scale = Vector2.all(1.0);
    final scaleEffect = ScaleEffect.by(
      Vector2.all(2.1),
      EffectController(duration: 0.3),
      onComplete: () {
        scale = Vector2.all(1.0);
      },
    );

    add(scaleEffect);
  }
}

class RotatableTextComponent extends TextBoxComponent {
  RotatableTextComponent({
    super.text,
    super.textRenderer,
    super.boxConfig,
    super.anchor = Anchor.center,
    super.position,
    super.children,
    super.priority = 110,
    bool isScaleAndDisappear = false,
    double scale = 1.0,
    double opacity = 1.0,
    double scaleSpeed = 0.2,
    double opacitySpeed = 0.4,
    void Function()? onComplete,
  }) {
    if (isScaleAndDisappear) scaleRotateAndDisappear(onComplete);
  }

  var isPlus = true;

  void scaleRotateAndDisappear(void Function()? onComplete) {
    scale = Vector2.all(0.75);
    final scaleEffect = ScaleEffect.by(
      Vector2.all(2.1),
      EffectController(duration: 0.75),
      onComplete: () {
        // scale = Vector2.all(1.0);
        // angle = 0;
        removeFromParent();
        if (onComplete != null) onComplete();
      },
    );
    isPlus = Random().nextBool();

    // final rotateEffect = RotateEffect.to(12, EffectController(duration: 0.5),
    //     onComplete: () => angle = 0);
    // add(rotateEffect);

    add(scaleEffect);
  }

  @override
  void update(double dt) {
    if (scale.x >= 1.05) isPlus ? angle += 0.01 : angle -= 0.01;
    super.update(dt);
  }
}

class BandComponent extends TextBoxComponent {
  BandComponent({
    super.text,
    super.textRenderer,
    super.boxConfig,
    super.anchor = Anchor.center,
    super.position,
    super.children,
    super.priority = 110,
    super.size,
    required this.screenSize,
    double scale = 1.0,
    double opacity = 1.0,
    double scaleSpeed = 0.2,
    double opacitySpeed = 0.4,
  });

  double screenSize;
  var scroll = 3;
  var isScrolling = false;
  var speed = 1.0;

  startScroll({String? text, double speed = 1, int scroll = 3}) {
    this.scroll = scroll;
    this.speed = speed;
    isScrolling = true;

    this.text = text ?? this.text;
    position = Vector2(screenSize, position.y);
  }

  stopScroll() {
    isScrolling = false;
    scroll = 3;
    position = Vector2(size.x + screenSize, position.y);
  }

  @override
  void update(double dt) {
    if (scroll >= 0 && isScrolling) {
      if (scroll == 0) {
        stopScroll();
      }
      position = Vector2(position.x - (1 * speed), position.y);
      if (position.x < -size.x) {
        position = Vector2(screenSize, position.y);
        scroll--;
      }
    }

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    // renderDebugMode(canvas);
    super.render(canvas);
  }
}
