import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent {
  final JoystickComponent joystick;
  final double _speed = 80;

  late final SpriteAnimation _upWalkAnimation;
  late final SpriteAnimation _downWalkAnimation;
  late final SpriteAnimation _leftWalkAnimation;
  late final SpriteAnimation _rightWalkAnimation;

  Player({
    required Vector2? position,
    required Vector2? size,
    required Anchor? anchor,
    required this.joystick,
  }) : super(position: position, size: size, anchor: anchor);

  @override
  Future<void>? onLoad() async {
    final spriteSheet = SpriteSheet(
      image: await Flame.images.load('darksoldier_spritesheet.png'),
      srcSize: Vector2(64, 64),
    );

    _upWalkAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: 0.11, from: 0, to: 5);
    _downWalkAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.11, from: 0, to: 5);
    _leftWalkAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: 0.11, from: 0, to: 4);
    _rightWalkAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.11, from: 0, to: 4);

    this.animation = _upWalkAnimation;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * _speed * dt);
    }

    if (joystick.direction == JoystickDirection.left ||
        joystick.direction == JoystickDirection.downLeft ||
        joystick.direction == JoystickDirection.upLeft) {
      this.animation = _leftWalkAnimation;
    } else if (joystick.direction == JoystickDirection.right ||
        joystick.direction == JoystickDirection.downRight ||
        joystick.direction == JoystickDirection.upRight) {
      this.animation = _rightWalkAnimation;
    } else if (joystick.direction == JoystickDirection.down) {
      this.animation = _downWalkAnimation;
    } else {
      this.animation = _upWalkAnimation;
    }

    super.update(dt);
  }
}
