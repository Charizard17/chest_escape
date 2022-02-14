import 'dart:math';

import 'package:flame/components.dart';
import 'package:wall_passer_flame_game/game/game_canvas_size.dart';

import './game.dart';
import './wall.dart';

class WallManager extends Component
    with HasGameRef<WallPasserGame>, GameCanvasSize {
  final int _baseNumber = 8;
  final Sprite sprite;
  Random random = Random();
  late Timer _timer;

  WallManager({
    required this.sprite,
  }) : super() {
    _timer = Timer(2.5, repeat: true, onTick: _spawnWalls);
    _timer.start();
  }

  void _spawnWalls() {
    Vector2 initialSize = Vector2(this.gameCanvasSize.x / _baseNumber,
        this.gameCanvasSize.x / _baseNumber);
    Vector2 position = gameTopPadding +
        Vector2(this.gameCanvasSize.x / _baseNumber / 2,
            this.gameCanvasSize.x / _baseNumber / 2);

    final randomNumber = random.nextInt(_baseNumber);

    for (var i = 0; i < _baseNumber; ++i) {
      Wall wall = Wall(
        sprite: sprite,
        position:
            position + Vector2(i * this.gameCanvasSize.x / _baseNumber, 0),
        size: initialSize,
        anchor: Anchor.center,
      );

      if (randomNumber != i) {
        gameRef.add(wall);
      }
    }
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

  void reset() {
    _timer.stop();
    _timer.start();
  }
}
