import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player_data.g.dart';

@HiveType(typeId: 1)
class PlayerData extends ChangeNotifier with HiveObjectMixin {
  static const String PLAYER_DATA_BOX = 'PlayerDataBox';
  static const String PLAYER_DATA_KEY = 'PlayerDataKey';

  @HiveField(0)
  final List<GameScore> highScoresList;

  PlayerData({
    required this.highScoresList,
  });

  void addGameScoreToHighScores(score) {
    final gameScore = GameScore(score: score, dateTime: DateTime.now());
    this.highScoresList.add(gameScore);
    notifyListeners();
    this.save();
    print(this.highScoresList);
  }
}

class GameScore {
  final int score;
  final DateTime dateTime;

  GameScore({
    required this.score,
    required this.dateTime,
  });
}
