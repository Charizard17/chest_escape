import 'package:chest_escape/models/player_data.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

import './screens/game_play.dart';
import './models/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(
    MultiProvider(
      providers: [
        FutureProvider<Settings>(
          create: (BuildContext context) => null,
          initialData: Settings(soundEffects: false, backgroundMusic: false),
        ),
        FutureProvider<PlayerData>(
          create: (BuildContext context) => null,
          initialData: PlayerData.fromMap(PlayerData.defaultData),
        ),
      ],
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<Settings>.value(
              value: Provider.of<Settings>(context),
            ),
            ChangeNotifierProvider<PlayerData>.value(
              value: Provider.of<PlayerData>(context),
            ),
          ],
          child: child,
        );
      },
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Texturina',
        ),
        home: GamePlay(),
      ),
    ),
  );
}

// Future<Settings> getSettings() async {
//   return null;
// }

// Future<PlayerData> getPlayerData() async {
//   return null;
// }
