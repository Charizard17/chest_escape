import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';

import '../helpers/game_canvas_size.dart';
import '../helpers/command.dart';
import './player.dart';
import './wall_manager.dart';
import './wall.dart';
import '../overlays/game_over_menu.dart';
import '../overlays/pause_button.dart';

class WallPasserGame extends FlameGame
    with HasTappables, HasDraggables, HasCollidables, GameCanvasSize {
  late Player _player;
  late Wall _wall;
  late WallManager _wallManager;
  late SpriteComponent _background;

  int _gameLevel = 1;
  int get gameLevel => _gameLevel;

  late TextComponent _playerScore;
  late TextComponent _playerHealth;

  final _commandList = List<Command>.empty(growable: true);
  final _addLaterCommandList = List<Command>.empty(growable: true);

  @override
  Future<void>? onLoad() async {
    pauseEngine();

    await images.loadAll([
      'background_1.png',
      'background_2.png',
      'background_3.png',
      'background_4.png',
      'background_5.png',
      'darksoldier_spritesheet.png',
      'wall_1.png',
      'wall_2.png',
      'wall_3.png',
      'wall_4.png',
      'wall_5.png',
    ]);

    _background = SpriteComponent(
      sprite: Sprite(images.fromCache('background_1.png')),
      size: gameCanvasSize,
      position: gameTopPadding,
    );
    add(_background);

    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: gameCanvasSize.x / 12,
        paint: BasicPalette.white.withAlpha(100).paint(),
      ),
      background: RectangleComponent(
        size: Vector2(gameCanvasSize.x / 2, gameCanvasSize.x / 6),
        paint: BasicPalette.white.withAlpha(50).paint(),
      ),
      position: Vector2(gameCanvasSize.x / 2, gameCanvasSize.y + 150),
    );
    add(joystick);

    _player = Player(
      spriteSheet: SpriteSheet(
        image: images.fromCache('darksoldier_spritesheet.png'),
        srcSize: Vector2(64, 64),
      ),
      position: Vector2(gameCanvasSize.x / 2, gameCanvasSize.y - 30),
      anchor: Anchor.center,
      joystick: joystick,
    );
    add(_player);

    final playerPlatform = RectangleComponent(
      size: Vector2(gameCanvasSize.x, 15),
      paint: BasicPalette.white.withAlpha(100).paint(),
      position: Vector2(gameCanvasSize.x / 2, gameCanvasSize.y - 4),
      anchor: Anchor.center,
    );
    add(playerPlatform);

    _wallManager = WallManager(
      sprite: Sprite(images.fromCache('wall_1.png')),
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

    if (_player.playerScore >= 50) {
      _gameLevel = 2;
      this._background.sprite = Sprite(images.fromCache('background_2.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_2.png'));
    }
    if (_player.playerScore >= 150) {
      _gameLevel = 3;
      this._background.sprite = Sprite(images.fromCache('background_3.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_3.png'));
    }
    if (_player.playerScore >= 500) {
      _gameLevel = 4;
      this._background.sprite = Sprite(images.fromCache('background_4.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_4.png'));
    }
    if (_player.playerScore >= 1000) {
      _gameLevel = 5;
      this._background.sprite = Sprite(images.fromCache('background_5.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_5.png'));
    }

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

    if (_player.playerHealth <= 0 && !camera.shaking) {
      this.pauseEngine();
      overlays.remove(PauseButton.ID);
      overlays.add(GameOverMenu.ID);
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(gameCanvasSize.x - 130, 10,
          1.25 * _player.playerHealth.toDouble(), 25),
      Paint()..color = Color.fromARGB(255, 135, 11, 11),
    );
    super.render(canvas);
  }

  void addCommand(Command command) {
    _addLaterCommandList.add(command);
  }

  void reset() {
    this._background.sprite = Sprite(images.fromCache('background_1.png'));
    this._wallManager.sprite = Sprite(images.fromCache('wall_1.png'));
    this._gameLevel = 1;
    _player.reset();
    _wallManager.reset();

    children.whereType<Wall>().forEach((child) {
      child.removeFromParent();
    });

    final command = Command<Wall>(action: (wall) {
      wall.reset();
    });
    addCommand(command);
  }
}
