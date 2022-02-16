import 'package:flutter/material.dart';

import './pause_button.dart';
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
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Text(
                'Game Over',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.12,
              child: ElevatedButton.icon(
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  gameRef.overlays.remove(GameOverMenu.ID);
                  gameRef.overlays.add(PauseButton.ID);
                  gameRef.reset();
                  gameRef.resumeEngine();
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.12,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.black,
                  size: 30,
                ),
                label: Text(
                  'Main Menu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  // gameRef.overlays.remove(PauseMenu.ID);
                  // gameRef.reset();
                  // gameRef.resumeEngine();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
