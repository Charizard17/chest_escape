import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

import './game.dart';
import './game_canvas_size.dart';
import './wall.dart';

class Player extends SpriteAnimationComponent
    with GameCanvasSize, HasHitboxes, Collidable, HasGameRef<WallPasserGame> {
  final JoystickComponent joystick;
  final SpriteSheet spriteSheet;
  final double _speed = 150;

  int _playerScore = 0;
  int get playerScore => _playerScore;
  int _playerHealth = 100;
  int get playerHealth => _playerHealth;

  late final SpriteAnimation _upWalkAnimation;
  late final SpriteAnimation _downWalkAnimation;
  late final SpriteAnimation _leftWalkAnimation;
  late final SpriteAnimation _rightWalkAnimation;

  Player({
    required this.spriteSheet,
    required Vector2? position,
    required Anchor? anchor,
    required this.joystick,
  }) : super(position: position, anchor: anchor);

  @override
  Future<void>? onLoad() async {
    this.size = Vector2(gameCanvasSize.x / 6, gameCanvasSize.x / 6);
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

    this.position.clamp(
          Vector2(this.size.x / 4, this.size.y / 2 + gameTopPadding.y),
          Vector2(gameCanvasSize.x - this.size.x / 4,
              gameCanvasSize.y - this.size.y / 2 + gameTopPadding.y),
        );

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

  @override
  void onMount() {
    final hitbox = HitboxRectangle(relation: Vector2(0.5, 1));
    addHitbox(hitbox);

    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Wall) {
      _playerHealth -= 10;
      if (_playerHealth <= 0) {
        _playerHealth = 0;
      }

      gameRef.camera.shake(intensity: 5);
    }

    super.onCollision(intersectionPoints, other);
  }

  void increaseScore(int points) {
    _playerScore += points;
  }

  void reset() {
    this._playerHealth = 100;
    this._playerScore = 0;
    this.position = Vector2(200, 400);
  }
}
