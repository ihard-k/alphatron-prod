import 'dart:ui';

import 'package:alphatron/game/components/words_layout/word_component.dart';
import 'package:flame/components.dart';

class RowComponent extends PositionComponent {
  final List<WordComponent> childs;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;

  RowComponent({
    this.childs = const [],
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(children: childs);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    for (var child in children) {
      child.render(canvas);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (var child in children) {
      child.update(dt);
    }
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    layoutChildren();
  }

  void layoutChildren() {
    // Calculate the total width of all children
    double currentX = 0;
    double totalWidth = 0;
    for (var child in children) {
      totalWidth += (child as WordComponent).width;
    }

    // Adjust totalWidth with spacing
    totalWidth += spacing * (children.length - 1);

    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        currentX = 0;
        break;
      case MainAxisAlignment.center:
        // Ensure children are centered even if total width exceeds available space
        currentX = (size.x - totalWidth) / 2;
        break;
      case MainAxisAlignment.end:
        // Ensure children are aligned to the end even if total width exceeds available space
        currentX = size.x - totalWidth;
        break;
    }

    // Ensure currentX is at least 0
    currentX = currentX.clamp(0.0, double.infinity);

    // Position each child
    for (var child in children) {
      (child as WordComponent).position = Vector2(currentX, 0);
      currentX += child.width + spacing;
    }
  }
}

enum MainAxisAlignment { start, center, end }
