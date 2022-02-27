import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:intl/intl.dart';

class PlayerData extends ChangeNotifier {
  static const String PLAYER_DATA_BOX = 'PlayerDataBox';
  static const String PLAYER_DATA_KEY = 'PlayerDataKey';

  List _highScoresList = [];
  List get highScoresList => _highScoresList;

  // PlayerData({
  //   required this.highScoresList,
  // });

  void addGameScoreToHighScores(score) {
    List tempHighScoresList = [];
    final gameScore = {
      'score': score,
      'dateTime': DateFormat('dd.MM.yyyy').format(DateTime.now()),
    };
    _highScoresList.add(gameScore);
    _highScoresList.sort((b, a)=> a['score'].compareTo(b['score']));
    for (var i = 0; i < 10; ++i) {
      tempHighScoresList.add({
        'index': i+1,
        'score': _highScoresList[i]['score'],
        'dateTime': _highScoresList[i]['dateTime'],
      });
    }
    _highScoresList = tempHighScoresList;
    notifyListeners();
  }
}