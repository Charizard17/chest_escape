import 'package:flutter/material.dart';

class Settings extends ChangeNotifier {
  bool _backgroundMusic = false;
  bool get backgroundMusic => _backgroundMusic;
  set backgroundMusic(bool value) {
    _backgroundMusic = value;
    notifyListeners();
  }

  bool _soundEffects = false;
  bool get soundEffects => _soundEffects;
  set soundEffects(bool value) {
    _soundEffects = value;
    notifyListeners();
  }

  Settings({
    bool backgroundMusic = false,
    bool soundEffects = false,
  })  : this._backgroundMusic = backgroundMusic,
        this._soundEffects = soundEffects;
}
