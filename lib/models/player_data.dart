import 'package:chest_escape/helpers/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlayerData extends ChangeNotifier {
  List _highScoresList = [];

  List get highScoresList => _highScoresList;

  static Map<String, dynamic> defaultData = {
    'highScoresList': [],
  };

  void addGameScoreToHighScores(score) {
    final gameScore = {
      'id': DateTime.now().toString(),
      'score': score,
      'date': DateFormat('dd.MM.yyyy').format(DateTime.now()),
    };
    _highScoresList.add(gameScore);
    notifyListeners();
    DBHelper.insert(
      'player_data',
      {
        'id': gameScore['id'],
        'score': gameScore['score'],
        'date': gameScore['date'],
      },
    );
  }

  highScoresToTop10HighScores() {
    _highScoresList.sort((b, a) => a['score'].compareTo(b['score']));

    List tempList = _highScoresList;
    if (tempList.length > 10) {
      tempList.length = 10;
    }

    List top10HighScores = [];
    // following lines needs improvemet
    // it is not an efficent way to solve this issue
    for (var i = 0; i < tempList.length; ++i) {
      if (top10HighScores.length < 10) {
        top10HighScores.add(
          {
            'index': (i + 1).toString(),
            'score': tempList[i]['score'].toString(),
            'date': tempList[i]['date'],
          },
        );
      }
    }
    return top10HighScores;
  }

  Future<dynamic> fetchAndSetPlayerData() async {
    final dataList = await DBHelper.getData('player_data');
    _highScoresList = dataList
        .map(
          (item) => {
            'id': item['id'],
            'score': item['score'],
            'date': item['date'],
          },
        )
        .toList();
    notifyListeners();
  }
}
