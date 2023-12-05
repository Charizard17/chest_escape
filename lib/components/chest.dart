import 'package:flame/components.dart';

import '../game/game.dart';
import './player.dart';
import '../helpers/command.dart';
import '../helpers/game_canvas_size.dart';

class Chest extends PositionComponent
    with HasHitboxes, Collidable, HasGameRef<ChestEscape>, GameCanvasSize {
  int _increaseScoreBy = 1;
  int _gameLevel = 1;

  double _speed = 3.0;

  Chest({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required Anchor? anchor,
  }) : super(sprite: sprite, position: position, size: size, anchor: anchor);

  @override
  void update(double dt) {
    // update chest horizontal coordinate by speed variable
    this.position.y += _speed;

    if (_gameLevel < gameRef.gameLevel) {
      _gameLevel = gameRef.gameLevel;
      _increaseScoreBy = _gameLevel;
      _speed = _speed + (_gameLevel - 1) * 0.25;
    }

    if (this.position.y > gameCanvasSize.y + this.size.y / 2) {
      removeFromParent();

      final command = Command<Player>(action: (player) {
        player.increaseScore(_increaseScoreBy);
      });
      gameRef.addCommand(command);
    }

    super.update(dt);
  }

  @override
  void onMount() {
    final hitbox = HitboxRectangle(relation: Vector2(0.85, 0.85));
    addHitbox(hitbox);

    super.onMount();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Player) {
      removeFromParent();

      final command = Command<Player>(action: (player) {
        player.increaseScore(_increaseScoreBy * 2);
      });
      gameRef.addCommand(command);
    }

    super.onCollision(intersectionPoints, other);
  }

  void reset() {
    this._increaseScoreBy = 1;
    this._speed = 3.0;
  }
}
