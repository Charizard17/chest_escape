import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'player_data.g.dart';

@HiveType(typeId: 1)
class PlayerData extends ChangeNotifier with HiveObjectMixin {
  static const String PLAYER_DATA_BOX = 'PlayerDataBox';
  static const String PLAYER_DATA_KEY = 'PlayerDataKey';

  @HiveField(0)
  final List highScoresList;

  PlayerData({
    required this.highScoresList,
  });

  void addGameScoreToHighScores(score) {
    final gameScore = {
      'score': score,
      'dateTime': DateTime.now(),
    };
    this.highScoresList.add(gameScore);
    notifyListeners();
    this.save();
  }

  PlayerData.fromMap(
    Map<String, dynamic> map,
  ) : this.highScoresList = map['highScoresList'];

  static Map<String, dynamic> defaultData = {
    'score': 0,
    'dateTime': '2022-02-22 21:31:06.304287',
  };
}
