import 'dart:math';

import 'package:flame/components.dart';

import './game.dart';
import './wall.dart';
import '../helpers/game_canvas_size.dart';

class WallManager extends Component
    with HasGameRef<WallPasserGame>, GameCanvasSize {
  final int _baseNumber = 8;
  int _gameLevel = 1;
  Random random = Random();
  late Timer _timer;
  late Sprite sprite;

  WallManager({
    required this.sprite,
  }) : super() {}

  @override
  Future<void>? onLoad() {
    _timer = Timer(3, repeat: true, onTick: _spawnWalls);
    return super.onLoad();
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

    if (_gameLevel < gameRef.gameLevel) {
      _gameLevel = gameRef.gameLevel;

      var newLimit = (3 / (1 + (0.05 * _gameLevel)));
      print(newLimit);

      _timer.stop();
      _timer = Timer(newLimit, repeat: true, onTick: _spawnWalls);
      _timer.start();
    }
  }

  void reset() {
    _timer.stop();
    _timer = Timer(3, repeat: true, onTick: _spawnWalls);
    _timer.start();
  }
}
