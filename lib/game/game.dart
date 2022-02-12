import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';

import './game_canvas_size.dart';
import './player.dart';
import './wall_manager.dart';
import './wall.dart';

class WallPasserGame extends FlameGame
    with HasTappables, HasDraggables, HasCollidables, GameCanvasSize {
  late Player _player;
  late Wall _wall;
  late WallManager _wallManager;

  late TextComponent _playerScore;
  late TextComponent _playerHealth;

  @override
  Future<void>? onLoad() async {
    await images.loadAll([
      'background.png',
      'darksoldier_spritesheet.png',
      'wall.png',
    ]);

    final backgroundImage = images.fromCache('background.png');
    final backgroundSpriteComponent = SpriteComponent(
      sprite: Sprite(backgroundImage),
      size: canvasSize,
    );
    add(backgroundSpriteComponent);

    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 24,
        paint: BasicPalette.black.withAlpha(100).paint(),
      ),
      background: CircleComponent(
        radius: 60,
        paint: BasicPalette.black.withAlpha(100).paint(),
      ),
      margin: const EdgeInsets.only(right: 50, bottom: 40),
    );
    add(joystick);

    _player = Player(
      spriteSheet: SpriteSheet(
        image: images.fromCache('darksoldier_spritesheet.png'),
        srcSize: Vector2(64, 64),
      ),
      position: Vector2(200, 400),
      anchor: Anchor.center,
      joystick: joystick,
    );
    add(_player);

    _wallManager = WallManager(
      sprite: Sprite(images.fromCache('wall.png')),
    );
    add(_wallManager);

    _playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
    add(_playerScore);

    _playerHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(canvasSize.x - 120, 10),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
    add(_playerHealth);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    _playerHealth.text = 'Health: ${_player.playerHealth}%';

    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(
      Rect.fromLTWH(size.x - 120, 30, 1.1 * _player.playerHealth.toDouble(), 5),
      Paint()..color = Color.fromARGB(255, 203, 29, 29),
    );
  }
}
