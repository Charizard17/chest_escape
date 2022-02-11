import 'dart:math';

import 'package:flame/components.dart';
import 'package:wall_passer_flame_game/game/game_canvas_size.dart';

import './game.dart';
import './wall.dart';

class WallManager extends Component
    with HasGameRef<WallPasserGame>, GameCanvasSize {
  final Sprite sprite;
  Random random = Random();
  late Timer _timer;

  WallManager({
    required this.sprite,
  }) : super() {
    _timer = Timer(1, repeat: true, onTick: _spawnWall);
    _timer.start();
  }

  void _spawnWall() {
    Vector2 initialSize = Vector2(50, 50);
    Vector2 position = Vector2(random.nextDouble() * this.gameSize.x, 0);

    Wall wall = Wall(
      sprite: sprite,
      position: position,
      size: initialSize,
      anchor: Anchor.center,
      canvasSize: this.gameSize,
    );

    gameRef.add(wall);
  }

  @override
  void onMount() {
    super.onMount();
    _timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
