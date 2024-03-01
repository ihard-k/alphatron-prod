import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/components.dart';

class BlurredTextBoxComponent extends TextBoxComponent {
  Color color;
  BlurredTextBoxComponent({
    String? text,
    required Vector2 position,
    required this.color,
    Vector2? size,
    required TextPaint textRenderer,
  }) : super(
          text: text,
          size: size,
          position: position,
          priority: 10,
          align: Anchor.center,
          textRenderer: textRenderer,
        );

  @override
  void render(Canvas canvas) {
    // Apply the blur effect before drawing the text
    final paint = Paint()
      ..color = color
      ..imageFilter = ui.ImageFilter.blur(
          sigmaX: 2.0, sigmaY: 5.0, tileMode: TileMode.decal);

    // Save the canvas state
    canvas.saveLayer(calculateBounds(), paint);

    // Call the super method to draw the text normally
    super.render(canvas);

    // Restore the canvas to remove the blur effect from subsequent renders
    canvas.restore();
  }

  Rect calculateBounds() {
    return Rect.fromLTWH(0, 0, size.x, size.y);
  }
}
