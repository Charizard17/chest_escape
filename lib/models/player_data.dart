import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'player_data.g.dart';

@HiveType(typeId: 1)
class PlayerData extends ChangeNotifier with HiveObjectMixin {
  static const String PLAYER_DATA_BOX = 'PlayerDataBox';
  static const String PLAYER_DATA_KEY = 'PlayerDataKey';

  @HiveField(0)
  List highScoresList;

  PlayerData({
    required this.highScoresList,
  });

  PlayerData.fromMap(Map map) : this.highScoresList = map['highScoresList'];

  static Map<String, dynamic> defaultData = {
    'highScoresList': [],
  };

  void addGameScoreToHighScores(score) {
    // List tempHighScoresList = [];
    final gameScore = {
      'score': score,
      'dateTime': DateFormat('dd.MM.yyyy').format(DateTime.now()),
    };
    highScoresList.add(gameScore);
    // highScoresList.sort((b, a) => a['score'].compareTo(b['score']));
    // for (var i = 0; i < 10; ++i) {
    //   tempHighScoresList.add({
    //     'index': i + 1,
    //     'score': highScoresList[i]['score'],
    //     'dateTime': highScoresList[i]['dateTime'],
    //   });
    // }
    // highScoresList = tempHighScoresList;
    notifyListeners();
  }
}
