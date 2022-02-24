import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './main_menu.dart';
import '../game/game.dart';

class HighScores extends StatelessWidget {
  static const String ID = 'HighScores';
  final ChestEscape gameRef;

  const HighScores({
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
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Text(
                  'High Scores',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
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
                  tableRow('1', '1234', '24.02.2022'),
                  tableRow('2', '1017', '21.02.2022'),
                  tableRow('3', '934', '22.02.2022'),
                  tableRow('4', '925', '24.02.2022'),
                  tableRow('5', '842', '23.02.2022'),
                  tableRow('6', '817', '21.02.2022'),
                  tableRow('7', '799', '17.02.2022'),
                  tableRow('8', '775', '20.02.2022'),
                  tableRow('9', '730', '19.02.2022'),
                  tableRow('10', '653', '22.02.2022'),
                ],
              ),
              SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.12,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  label: Text(
                    'Back',
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
