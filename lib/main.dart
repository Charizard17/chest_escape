import 'package:chest_escape/components/player.dart';
import 'package:chest_escape/models/player_data.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import './screens/game_play.dart';
import './models/settings.dart';
import './models/player_data.dart';

PlayerData _playerData = PlayerData();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  await initHive();

  runApp(
    FutureProvider<Settings>(
      create: (BuildContext context) => getSettings(),
      initialData: Settings(soundEffects: false, backgroundMusic: false),
      builder: (context, child) {
        return ChangeNotifierProvider<Settings>.value(
          value: Provider.of<Settings>(context),
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'Texturina',
            ),
            home: GamePlay(),
          ),
        );
      },
    ),
  );
}

Future<void> initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(SettingsAdapter());
}

Future<Settings> getSettings() async {
  final box = await Hive.openBox<Settings>(Settings.BOX_NAME);
  final settings = box.get(Settings.BOX_KEY);
  if (settings == null) {
    box.put(
        Settings.BOX_KEY, Settings(soundEffects: true, backgroundMusic: true));
  }
  return box.get(Settings.BOX_KEY)!;
}
