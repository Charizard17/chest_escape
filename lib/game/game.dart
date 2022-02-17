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
import '../overlays/pause_menu.dart';
import '../overlays/pause_button.dart';

class WallPasserGame extends FlameGame
    with HasTappables, HasDraggables, HasCollidables, GameCanvasSize {
  // following variables necessary for initializing image and audio assets
  static const _imageAssets = [
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
  ];

  static const _audioAssets = [
    'SynthBomb.wav',
    'wall_hit_sound.mp3',
  ];

  late Player _player;
  late WallManager _wallManager;
  late SpriteComponent _background;
  late TextComponent _playerScore;
  late TextComponent _playerHealth;

  // set game level to 1 on the beginning and set a getter for it
  int _gameLevel = 1;
  int get gameLevel => _gameLevel;

  // initialize command list and add later command list
  // these lists is reqiured for command class implementation
  final _commandList = List<Command>.empty(growable: true);
  final _addLaterCommandList = List<Command>.empty(growable: true);

  @override
  Future<void>? onLoad() async {
    // on beginning the app starts using this FlameGame class
    // main_menu, settings, and other screens are overlays
    // users see the main menu, but flame game continues in the background
    // thats why the game should be paused
    pauseEngine();

    // load all images
    await images.loadAll(_imageAssets);

    // initialize game background with sprite component
    // sprite image will change by game level
    _background = SpriteComponent(
      sprite: Sprite(images.fromCache('background_1.png')),
      size: gameCanvasSize,
      position: gameTopPadding,
    );
    add(_background);

    // joystick component added to game before player,
    // because it is a parameter in player class
    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: gameCanvasSize.x / 12,
        paint: Paint()..color = const Color(0xffffbf00).withAlpha(150),
      ),
      background: RectangleComponent(
        size: Vector2(gameCanvasSize.x / 2, gameCanvasSize.x / 6),
        paint: Paint()..color = const Color(0xffffbf00).withAlpha(50),
      ),
      position: Vector2(gameCanvasSize.x / 2, gameCanvasSize.y + 150),
    );
    add(joystick);

    // add player to the game
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

    // this is basically a platform effect, where player stand on
    final playerPlatform = RectangleComponent(
      size: Vector2(gameCanvasSize.x, 15),
      paint: BasicPalette.white.withAlpha(100).paint(),
      position: Vector2(gameCanvasSize.x / 2, gameCanvasSize.y - 4),
      anchor: Anchor.center,
    );
    add(playerPlatform);

    // add wall manager to the game. it generates walls automatically
    _wallManager = WallManager(
      sprite: Sprite(images.fromCache('wall_1.png')),
    );
    add(_wallManager);

    // show player score as flame text component
    // update score if walls destroyed or player hits a wall
    _playerScore = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 10),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          color: Colors.amber,
        ),
      ),
    );
    _playerScore.positionType = PositionType.viewport;
    add(_playerScore);

    // show player health as flame text component
    // update player health if a wall hits to the player
    _playerHealth = TextComponent(
      text: 'Health: 100%',
      position: Vector2(canvasSize.x - 10, 10),
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          color: Colors.amber,
        ),
      ),
    );
    _playerHealth.anchor = Anchor.topRight;
    _playerHealth.positionType = PositionType.viewport;
    add(_playerHealth);

    return super.onLoad();
  }

  // change default flame background black to an other color
  @override
  Color backgroundColor() {
    return Colors.black.withOpacity(0.8);
  }

  // if player minimize the app or open an another app
  // then it means app lifecycle state is not resumed
  // if it is so, pause the game and show pause menu
  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        if (this._player.playerHealth > 0) {
          this.pauseEngine();
          this.overlays.remove(PauseButton.ID);
          this.overlays.add(PauseMenu.ID);
        }
    }
    super.lifecycleStateChange(state);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // update game level
    // change background image sprite and wall image sprite by game level
    if (_player.playerScore >= 50/10) {
      _gameLevel = 2;
      this._background.sprite = Sprite(images.fromCache('background_2.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_2.png'));
    }
    if (_player.playerScore >= 150/10) {
      _gameLevel = 3;
      this._background.sprite = Sprite(images.fromCache('background_3.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_3.png'));
    }
    if (_player.playerScore >= 500/10) {
      _gameLevel = 4;
      this._background.sprite = Sprite(images.fromCache('background_4.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_4.png'));
    }
    if (_player.playerScore >= 1000/10) {
      _gameLevel = 5;
      this._background.sprite = Sprite(images.fromCache('background_5.png'));
      this._wallManager.sprite = Sprite(images.fromCache('wall_5.png'));
    }

    // this lines are required for command class implementation
    _commandList.forEach((command) {
      children.forEach((child) {
        command.run(child);
      });
    });

    _commandList.clear();
    _commandList.addAll(_addLaterCommandList);
    _addLaterCommandList.clear();

    // update player score and player health score
    _playerScore.text = 'Score: ${_player.playerScore}';
    _playerHealth.text = 'Health: ${_player.playerHealth}%';

    // if player is dead show game over menu
    if (_player.playerHealth <= 0 && !camera.shaking) {
      this.pauseEngine();
      overlays.remove(PauseButton.ID);
      overlays.add(GameOverMenu.ID);
    }
  }

  @override
  void render(Canvas canvas) {
    // change this health bar by player health percentage
    canvas.drawRect(
      Rect.fromLTWH(gameCanvasSize.x - 130, 10,
          1.25 * _player.playerHealth.toDouble(), 21),
      Paint()..color = Color.fromARGB(255, 125, 10, 10),
    );
    super.render(canvas);
  }

  // this method is required for command class implementation
  void addCommand(Command command) {
    _addLaterCommandList.add(command);
  }

  // reset everything
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
