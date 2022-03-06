import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:provider/provider.dart';

import '../components/audio_manager.dart';
import '../components/chest_manager.dart';
import '../components/player.dart';
import '../components/chest.dart';
import '../models/player_data.dart';
import '../screens/main_menu.dart';
import '../screens/settings_menu.dart';
import '../models/settings.dart';
import '../helpers/command.dart';
import '../helpers/game_canvas_size.dart';
import '../overlays/game_over_menu.dart';
import '../overlays/pause_menu.dart';
import '../overlays/pause_button.dart';

class ChestEscape extends FlameGame
    with HasTappables, HasDraggables, HasCollidables, GameCanvasSize {
  // following variables necessary for initializing image and audio assets
  static const _imageAssets = [
    'background_1.png',
    'background_2.png',
    'background_3.png',
    'background_4.png',
    'background_5.png',
    'darksoldier_spritesheet.png',
    'chest_1.png',
    'chest_2.png',
    'chest_3.png',
    'chest_4.png',
    'chest_5.png',
  ];

  static const _audioAssets = [
    'SynthBomb.wav',
    'hit_sound.mp3',
  ];

  late Player _player;
  late ChestManager _chestManager;
  late SpriteComponent _background;
  late TextComponent _playerScoreTextComponent;
  late TextComponent _playerHealthTextComponent;
  late TextComponent _gameLevelTextComponent;
  late AudioManager _audioManager;

  late PlayerData _playerData;
  PlayerData get playerData => _playerData;

  // set game level to 1 on the beginning and set a getter for it
  int _gameLevel = 1;
  int get gameLevel => _gameLevel;
  int _scoreToGameLevelIndex = 30;

  int get endGameScore => _player.playerScore;

  // initialize command list and add later command list
  // these lists is reqiured for command class implementation
  final _commandList = List<Command>.empty(growable: true);
  final _addLaterCommandList = List<Command>.empty(growable: true);

  @override
  Future<void>? onLoad() async {
    // on beginning the app starts using this FlameGame class
    // main_menu, settings, and other screens are overlays
    // users see the main menu, but flame game continues in the background
    // thats why the game should be paused initially
    pauseEngine();

    // load all images
    await images.loadAll(_imageAssets);

    _audioManager = AudioManager();
    add(_audioManager);

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
        paint: Paint()
          ..shader = RadialGradient(
            radius: 0.2,
            center: Alignment.bottomRight,
            colors: [
              Colors.amber.withAlpha(200),
              Colors.black87,
            ],
            tileMode: TileMode.repeated,
          ).createShader(Rect.fromCircle(
              center: Offset(1, 1), radius: gameCanvasSize.x / 12)),
      ),
      background: RectangleComponent(
        size: Vector2(gameCanvasSize.x / 2, gameCanvasSize.x / 6),
        paint: Paint()..color = Colors.amber.withAlpha(70),
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

    // add chest manager to the game. it generates chests automatically
    _chestManager = ChestManager(
      sprite: Sprite(images.fromCache('chest_1.png')),
    );
    add(_chestManager);

    // show player score as flame text component
    // update score if chests destroyed or player hits a chest
    _playerScoreTextComponent = TextComponent(
      text: 'Score: 0',
      position: Vector2(10, 7),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Texturina',
          fontSize: 20,
          color: Colors.amber,
        ),
      ),
    );
    _playerScoreTextComponent.positionType = PositionType.viewport;
    add(_playerScoreTextComponent);

    
    // show player score as flame text component
    // update score if chests destroyed or player hits a chest
    _gameLevelTextComponent = TextComponent(
      text: 'LvL: 1',
      position: Vector2(canvasSize.x/2 - 40, 7),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Texturina',
          fontSize: 20,
          color: Colors.amber,
        ),
      ),
    );
    _gameLevelTextComponent.positionType = PositionType.viewport;
    add(_gameLevelTextComponent);

    // show player health as flame text component
    // update player health if a chest hits to the player
    _playerHealthTextComponent = TextComponent(
      text: 'Health: 100%',
      position: Vector2(canvasSize.x - 10, 7),
      textRenderer: TextPaint(
        style: TextStyle(
          fontFamily: 'Texturina',
          fontSize: 20,
          color: Colors.amber,
        ),
      ),
    );
    _playerHealthTextComponent.anchor = Anchor.topRight;
    _playerHealthTextComponent.positionType = PositionType.viewport;
    add(_playerHealthTextComponent);

    return super.onLoad();
  }

  @override
  void onAttach() {
    _playerData = PlayerData();
    _playerData.fetchAndSetPlayerData();

    _audioManager.playBackgroundMusic('SynthBomb.wav');

    super.onAttach();
  }

  @override
  void onDetach() {
    _audioManager.stopBackgroundMusic();

    super.onDetach();
  }

  // change default flame background black to an other color
  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  // if player minimize the app or open an another app
  // then it means app lifecycle state is not resumed
  // if it is so, pause the game and show pause menu
  @override
  void lifecycleStateChange(AppLifecycleState state) {
    if (!(this.overlays.isActive(MainMenu.ID)) &&
        !(this.overlays.isActive(SettingsMenu.ID))) {
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
    }
    super.lifecycleStateChange(state);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // update game level
    // change background image sprite and chest image sprite by game level
    if (_gameLevel < 5 && _player.playerScore >= _scoreToGameLevelIndex) {
      _scoreToGameLevelIndex *= 4;
      ++_gameLevel;
      this._background.sprite =
          Sprite(images.fromCache('background_$gameLevel.png'));
      this._chestManager.sprite =
          Sprite(images.fromCache('chest_$_gameLevel.png'));
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
    _playerScoreTextComponent.text = 'Score: ${_player.playerScore}';
    _playerHealthTextComponent.text = 'Health: ${_player.playerHealth}%';
    _gameLevelTextComponent.text = 'LvL: $_gameLevel';

    // if player is dead show game over menu
    if (_player.playerHealth <= 0 && !camera.shaking) {
      overlays.remove(PauseButton.ID);
      overlays.add(GameOverMenu.ID);
      _playerData.addGameScoreToHighScores(_player.playerScore);
      this.pauseEngine();
    }
  }

  @override
  void render(Canvas canvas) {
    final rectangle = Rect.fromLTWH(0, 0, size.x, size.y);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.y, size.x),
      Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.9, 0.1),
          colors: [
            Colors.grey,
            Colors.black,
          ],
          tileMode: TileMode.repeated,
        ).createShader(rectangle)
        ..strokeWidth = size.x * 3,
    );

    // change this health bar by player health percentage
    canvas.drawRect(
      Rect.fromLTWH(gameCanvasSize.x - 130, 9,
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
    this._scoreToGameLevelIndex = 30;
    this._background.sprite = Sprite(images.fromCache('background_1.png'));
    this._chestManager.sprite = Sprite(images.fromCache('chest_1.png'));
    this._gameLevel = 1;
    _player.reset();
    _chestManager.reset();

    children.whereType<Chest>().forEach((child) {
      child.removeFromParent();
    });

    final command = Command<Chest>(action: (chest) {
      chest.reset();
    });
    addCommand(command);
  }
}
