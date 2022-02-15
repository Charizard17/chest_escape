import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:wall_passer_flame_game/helpers/game_canvas_size.dart';

import './game.dart';
import './player.dart';
import '../helpers/command.dart';

class Wall extends SpriteComponent
    with HasHitboxes, Collidable, HasGameRef<WallPasserGame>, GameCanvasSize {
  double _speed = 1.4;

  Wall({
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required Anchor? anchor,
  }) : super(sprite: sprite, position: position, size: size, anchor: anchor);

  @override
  Future<void>? onLoad() async {
    return super.onLoad();
  }

  @override
  void update(double dt) {
    this.position.y += _speed;

    if (this.position.y > gameCanvasSize.y + this.size.y / 2) {
      removeFromParent();

      final command = Command<Player>(action: (player) {
        player.increaseScore(1);
      });
      gameRef.addCommand(command);
    }

    if (gameRef.gameLevel == 2) {
      _speed = 1.8;
    }
    if (gameRef.gameLevel == 3) {
      _speed = 2.2;
    }
    if (gameRef.gameLevel == 4) {
      _speed = 2.5;
    }
    if (gameRef.gameLevel == 5) {
      _speed = 3;
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
        player.increaseScore(1);
      });
      gameRef.addCommand(command);
    }

    super.onCollision(intersectionPoints, other);
  }

  void reset() {
    this._speed = 1.4;
  }
}
