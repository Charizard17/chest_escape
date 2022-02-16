import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import './main_menu.dart';
import './settings_menu.dart';
import '../game/game.dart';
import '../overlays/game_over_menu.dart';
import '../overlays/pause_menu.dart';
import '../overlays/pause_button.dart';

final WallPasserGame _wallPasserGame = WallPasserGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          body: GameWidget(
            game: _wallPasserGame,
            initialActiveOverlays: [MainMenu.ID],
            overlayBuilderMap: {
              MainMenu.ID: (BuildContext context, WallPasserGame gameRef) =>
                  MainMenu(gameRef: gameRef),
              SettingsMenu.ID: (BuildContext context, WallPasserGame gameRef) =>
                  SettingsMenu(gameRef: gameRef),
              PauseButton.ID: (BuildContext context, WallPasserGame gameRef) =>
                  PauseButton(gameRef: gameRef),
              PauseMenu.ID: (BuildContext context, WallPasserGame gameRef) =>
                  PauseMenu(gameRef: gameRef),
              GameOverMenu.ID: (BuildContext context, WallPasserGame gameRef) =>
                  GameOverMenu(gameRef: gameRef),
            },
          ),
        ),
      ),
    );
  }
}
