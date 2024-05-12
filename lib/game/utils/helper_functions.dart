import 'package:flame/components.dart';
import 'package:flame/flame.dart';

Future<SpriteComponent> loadImage(
  String image, {
  Vector2? size,
  Vector2? position,
  int? priority,
  Anchor? anchor,
}) async {
  var bg = await Flame.images.load(image);
  final sprite = SpriteComponent(sprite: Sprite(bg), size: size,priority: priority, position: position,anchor: anchor);
  return sprite;
}
