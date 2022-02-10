import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';

import './player.dart';

class WallPasserGame extends FlameGame {
  late Player _player;

  @override
  Future<void>? onLoad() async {
    _player = Player(
      position: Vector2(150, 150),
      size: Vector2(100, 100),
      anchor: Anchor.center,
    );

    add(_player);

    return super.onLoad();
  }
}
