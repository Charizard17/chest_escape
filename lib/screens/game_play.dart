import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../game/game.dart';

final WallPasserGame _wallPasserGame = WallPasserGame();

class GamePlay extends StatelessWidget {
  const GamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          body: GameWidget(
            game: _wallPasserGame,
          ),
        ),
      ),
    );
  }
}
