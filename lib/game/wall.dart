import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:wall_passer_flame_game/helpers/game_canvas_size.dart';

import './game.dart';
import './player.dart';
import '../helpers/command.dart';

class Wall extends SpriteComponent
    with HasHitboxes, Collidable, HasGameRef<WallPasserGame>, GameCanvasSize {
  int _increaseScoreBy = 1;
  int _gameLevel = 1;

  late double speed;

  Wall({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required Anchor? anchor,
    required this.speed,
  }) : super(sprite: sprite, position: position, size: size, anchor: anchor);

  @override
  void update(double dt) {
    // update wall horizontal coordinate by speed variable
    this.position.y += speed;

    if (this.position.y > gameCanvasSize.y + this.size.y / 2) {
      removeFromParent();

      final command = Command<Player>(action: (player) {
        player.increaseScore(1);
      });
      gameRef.addCommand(command);
    }

    if (_gameLevel < gameRef.gameLevel) {
      _gameLevel = gameRef.gameLevel;
      _increaseScoreBy = _gameLevel;
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
        player.increaseScore(_increaseScoreBy);
      });
      gameRef.addCommand(command);
    }

    super.onCollision(intersectionPoints, other);
  }

  void reset() {
    this._increaseScoreBy = 1;
  }
}
