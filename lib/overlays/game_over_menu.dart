import 'package:flutter/material.dart';

import '../screens/main_menu.dart';
import './pause_button.dart';
import '../game/game.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';
  final ChestEscape gameRef;

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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Final score: ${gameRef.endGameScore}',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.12,
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.restart_alt,
                  color: Colors.black,
                  size: 30,
                ),
                label: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Restart',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
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
                label: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Main Menu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
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
                  gameRef.overlays.add(MainMenu.ID);
                  gameRef.reset();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
