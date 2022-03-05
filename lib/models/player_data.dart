import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerData extends ChangeNotifier {
  List highScoresList;

  PlayerData({
    required this.highScoresList,
  });

  PlayerData.fromMap(Map map) : this.highScoresList = map['highScoresList'];

  static Map<String, dynamic> defaultData = {
    'highScoresList': [],
  };

  void addGameScoreToHighScores(score) {
    final gameScore = {
      'score': score,
      'dateTime': DateFormat('dd.MM.yyyy').format(DateTime.now()),
    };
    highScoresList.add(gameScore);
    notifyListeners();
  }
}
