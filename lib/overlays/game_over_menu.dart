import 'package:flutter/material.dart';

import '../game/game.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';
  final WallPasserGame gameRef;

  const GameOverMenu({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        height: 200,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over',
              style: TextStyle(
                fontSize: 40,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(
                Icons.restart_alt,
                color: Colors.black,
                size: 30,
              ),
              label: Text(
                'Restart',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
              onPressed: () {
                gameRef.overlays.remove(GameOverMenu.ID);
                gameRef.reset();
                gameRef.resumeEngine();
              },
            ),
          ],
        ),
      ),
    );
  }
}
