import 'package:flutter/material.dart';
import 'package:wall_passer_flame_game/overlays/pause_button.dart';

import '../game/game.dart';

class PauseMenu extends StatelessWidget {
  static const String ID = 'PauseMenu';
  final WallPasserGame gameRef;

  const PauseMenu({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Paused',
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
                'Resume',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
                gameRef.resumeEngine();
              },
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
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(PauseButton.ID);
                gameRef.reset();
                gameRef.resumeEngine();
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
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
              ),
              onPressed: () {
                // gameRef.overlays.remove(PauseMenu.ID);
                // gameRef.reset();
                // gameRef.resumeEngine();
              },
            ),
          ],
        ),
      ),
    );
  }
}
