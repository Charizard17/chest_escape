import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'settings.g.dart';

@HiveType(typeId: 0)
class Settings extends ChangeNotifier with HiveObjectMixin {
  static const String BOX_NAME = 'SettingsBox';
  static const String BOX_KEY = 'Settings';

  @HiveField(0)
  bool _backgroundMusic = false;

  bool get backgroundMusic => _backgroundMusic;
  set backgroundMusic(bool value) {
    _backgroundMusic = value;
    notifyListeners();
    this.save();
  }

  @HiveField(1)
  bool _soundEffects = false;

  bool get soundEffects => _soundEffects;
  set soundEffects(bool value) {
    _soundEffects = value;
    notifyListeners();
    this.save();
  }

  Settings({
    bool backgroundMusic = false,
    bool soundEffects = false,
  })  : this._backgroundMusic = backgroundMusic,
        this._soundEffects = soundEffects;
}
