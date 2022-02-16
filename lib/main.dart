import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import './screens/game_play.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(
    MaterialApp(
      home: GamePlay(),
    ),
  );
}
