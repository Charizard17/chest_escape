import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import './screens/game_play.dart';
import './screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(
    MaterialApp(
      home: MainMenu(),
    ),
  );
}
