import 'dart:math';

import 'package:flame/components.dart';

import '../game/game.dart';
import './chest.dart';
import '../helpers/game_canvas_size.dart';

class ChestManager extends Component
    with HasGameRef<ChestEscape>, GameCanvasSize {
  final int _baseNumber = 8;
  int _gameLevel = 1;

  Random random = Random();

  late Timer _timer;
  late Sprite sprite;

  ChestManager({
    required this.sprite,
  }) : super() {}

  @override
  Future<void>? onLoad() {
    _timer = Timer(3, repeat: true, onTick: _spawnChests);
    return super.onLoad();
  }

  void _spawnChests() {
    Vector2 initialSize = Vector2(this.gameCanvasSize.x / _baseNumber,
        this.gameCanvasSize.x / _baseNumber);
    Vector2 position = gameTopPadding +
        Vector2(this.gameCanvasSize.x / _baseNumber / 2,
            this.gameCanvasSize.x / _baseNumber / 2);

    final randomNumber = random.nextInt(_baseNumber);

    var randomNumberArray = <int>[0, 1, 2, 3, 4, 5, 6, 7];
    randomNumberArray.shuffle();
    randomNumberArray.removeRange(0, _baseNumber - (gameRef.gameLevel + 2));
    randomNumberArray.sort();

    for (var i = 0; i < randomNumberArray.length; ++i) {
      Chest chest = Chest(
        sprite: sprite,
        position: position +
            Vector2(
                randomNumberArray[i] * this.gameCanvasSize.x / _baseNumber, 0),
        size: initialSize,
        anchor: Anchor.center,
      );

      gameRef.add(chest);
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
      _timer.stop();
      _timer = Timer(newLimit, repeat: true, onTick: _spawnChests);
      _timer.start();
    }
  }

  void reset() {
    this._gameLevel = 1;
    _timer.stop();
    _timer = Timer(3, repeat: true, onTick: _spawnChests);
    _timer.start();
  }
}
