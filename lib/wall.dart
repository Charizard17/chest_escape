import 'package:flame/components.dart';

class Wall extends SpriteComponent {
  final double _speed = 2;
  late Vector2 canvasSize;

  Wall({
    Vector2? position,
    Vector2? size,
    Anchor? anchor,
    required this.canvasSize,
  }) : super(position: position, size: size, anchor: anchor);

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
      this.position.y = 0;
    }

    super.update(dt);
  }
}
