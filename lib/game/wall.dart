import 'package:flame/components.dart';

class Wall extends SpriteComponent {
  final double _speed = 2;
  late Vector2 canvasSize;

  Wall({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required Anchor? anchor,
    required this.canvasSize,
  }) : super(sprite: sprite, position: position, size: size, anchor: anchor);

  @override
  Future<void>? onLoad() async {
    final sprite = await Sprite.load('wall.png');

    this.sprite = sprite;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    this.position.y += _speed;

    if (this.position.y > canvasSize.y) {
      removeFromParent();
    }

    super.update(dt);
  }
}
