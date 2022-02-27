import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PlayerData extends ChangeNotifier {
  static const String PLAYER_DATA_BOX = 'PlayerDataBox';
  static const String PLAYER_DATA_KEY = 'PlayerDataKey';

  List highScoresList = [];

  // PlayerData({
  //   required this.highScoresList,
  // });

  void addGameScoreToHighScores(score) {
    final gameScore = {
      'score': score,
      'dateTime': DateTime.now(),
    };
    highScoresList.add(gameScore);
    notifyListeners();
  }
}