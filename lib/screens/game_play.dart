import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import './main_menu.dart';
import './settings_menu.dart';
import './high_scores.dart';
import '../game/game.dart';
import '../overlays/game_over_menu.dart';
import '../overlays/pause_menu.dart';
import '../overlays/pause_button.dart';

final ChestEscape _chestEscape = ChestEscape();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          body: GameWidget(
            game: _chestEscape,
            initialActiveOverlays: [MainMenu.ID],
            overlayBuilderMap: {
              MainMenu.ID: (BuildContext context, ChestEscape gameRef) =>
                  MainMenu(gameRef: gameRef),
              SettingsMenu.ID: (BuildContext context, ChestEscape gameRef) =>
                  SettingsMenu(gameRef: gameRef),
              HighScores.ID: (BuildContext context, ChestEscape gameRef) =>
                  HighScores(gameRef: gameRef),
              PauseButton.ID: (BuildContext context, ChestEscape gameRef) =>
                  PauseButton(gameRef: gameRef),
              PauseMenu.ID: (BuildContext context, ChestEscape gameRef) =>
                  PauseMenu(gameRef: gameRef),
              GameOverMenu.ID: (BuildContext context, ChestEscape gameRef) =>
                  GameOverMenu(gameRef: gameRef),
            },
          ),
        ),
      ),
    );
  }
}
