import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import './game/game.dart';

void main() {
  final WallPasserGame _game = WallPasserGame();

  runApp(
    GameWidget(
      game: _game,
    ),
  );
}
