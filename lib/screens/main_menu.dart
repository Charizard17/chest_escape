import 'package:flutter/material.dart';

import './settings_menu.dart';
import './high_scores.dart';
import '../overlays/pause_button.dart';
import '../game/game.dart';

class MainMenu extends StatelessWidget {
  static const String ID = 'MainMenu';
  final ChestEscape gameRef;

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
                Colors.black,
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Chest Escape',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Texturina',
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.12,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  label: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Start Game',
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
                    Icons.format_list_numbered_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  label: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'High Scores',
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
                    gameRef.overlays.remove(MainMenu.ID);
                    gameRef.overlays.add(HighScores.ID);
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
                  label: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Settings',
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
