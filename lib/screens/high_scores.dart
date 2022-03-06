import 'package:flutter/material.dart';

import './main_menu.dart';
import '../game/game.dart';

class HighScores extends StatelessWidget {
  static const String ID = 'HighScores';
  final ChestEscape gameRef;

  HighScores({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  tableRow(number, score, date) {
    return TableRow(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 18,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            score,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 18,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            date,
            style: TextStyle(
              color: Colors.amber,
              fontSize: 18,
              shadows: [
                Shadow(
                  blurRadius: 3,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _highScoresList = gameRef.playerData.highScoresToTop10HighScores();

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'High Scores',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              Table(
                children: [
                  tableRow('#', 'Score', 'Date'),
                  TableRow(
                    children: [
                      Divider(color: Colors.amber),
                      Divider(color: Colors.amber),
                      Divider(color: Colors.amber),
                    ],
                  ),
                  for (var highScore in _highScoresList)
                    tableRow('${highScore["index"]}', '${highScore["score"]}',
                        '${highScore["date"]}'),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.12,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  label: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Back',
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
                    gameRef.overlays.remove(HighScores.ID);
                    gameRef.overlays.add(MainMenu.ID);
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
