import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';

import './game_canvas_size.dart';
import './player.dart';
import './wall_manager.dart';
import './wall.dart';
import './command.dart';

class WallPasserGame extends FlameGame
    with HasTappables, HasDraggables, HasCollidables, GameCanvasSize {
  late Player _player;
  late Wall _wall;
  late WallManager _wallManager;

  late TextComponent _playerScore;
  late TextComponent _playerHealth;

  final _commandList = List<Command>.empty(growable: true);
  final _addLaterCommandList = List<Command>.empty(growable: true);

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
      size: gameCanvasSize,
      position: gameTopPadding,
    );
    add(backgroundSpriteComponent);

    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 24,
        paint: BasicPalette.white.withAlpha(100).paint(),
      ),
      background: CircleComponent(
        radius: 60,
        paint: BasicPalette.white.withAlpha(100).paint(),
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
          color: Colors.white,
        ),
      ),
    );
    _playerScore.positionType = PositionType.viewport;
    add(_playerScore);

    _playerHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(canvasSize.x - 10, 10),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
    _playerHealth.anchor = Anchor.topRight;
    _playerHealth.positionType = PositionType.viewport;
    add(_playerHealth);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    _commandList.forEach((command) {
      children.forEach((child) {
        command.run(child);
      });
    });

    _commandList.clear();
    _commandList.addAll(_addLaterCommandList);
    _addLaterCommandList.clear();

    _playerScore.text = 'Score: ${_player.playerScore}';
    _playerHealth.text = 'Health: ${_player.playerHealth}%';
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
          size.x - 125, 10, 1.2 * _player.playerHealth.toDouble(), 25),
      Paint()..color = Color.fromARGB(255, 135, 11, 11),
    );
    super.render(canvas);
  }

  void addCommand(Command command) {
    _addLaterCommandList.add(command);
  }
}
