import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent {
  late final SpriteAnimation _upWalkAnimation;
  late final SpriteAnimation _leftWalkAnimation;
  late final SpriteAnimation _rightWalkAnimation;

  Player({
    Vector2? position,
    Vector2? size,
    Anchor? anchor,
  }) : super(position: position, size: size, anchor: anchor);

  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('darksoldier_spritesheet.png'),
      srcSize: Vector2(64, 64),
    );

    _upWalkAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: 0.11, from: 0, to: 5);
    _leftWalkAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: 0.11, from: 0, to: 4);
    _rightWalkAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.11, from: 0, to: 4);

    this.animation = _upWalkAnimation;

    return super.onLoad();
  }
}
