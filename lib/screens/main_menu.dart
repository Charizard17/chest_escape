import 'package:flutter/material.dart';

import './settings_menu.dart';
import '../overlays/pause_button.dart';
import '../game/game.dart';

class MainMenu extends StatelessWidget {
  static const String ID = 'MainMenu';
  final WallPasserGame gameRef;

  const MainMenu({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.9, 0.1),
              colors: [
                Colors.grey,
                Colors.black87,
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Wall Passer',
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
                    Icons.play_circle_outline_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  label: Text(
                    'Start Game',
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
                    gameRef.overlays.remove(MainMenu.ID);
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
                    Icons.settings,
                    color: Colors.black,
                    size: 30,
                  ),
                  label: Text(
                    'Settings',
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
                    gameRef.overlays.remove(MainMenu.ID);
                    gameRef.overlays.add(SettingsMenu.ID);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
