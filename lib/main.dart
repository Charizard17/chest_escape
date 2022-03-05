import 'package:chest_escape/models/player_data.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import './screens/game_play.dart';
import './models/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  await initHive();

  runApp(
    MultiProvider(
      providers: [
        FutureProvider<Settings>(
          create: (BuildContext context) => getSettings(),
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

Future<void> initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(SettingsAdapter());
}

Future<Settings> getSettings() async {
  final box = await Hive.openBox<Settings>(Settings.BOX_NAME);
  final settings = box.get(Settings.BOX_KEY);
  if (settings == null) {
    box.put(Settings.BOX_KEY,
        Settings(soundEffects: true, backgroundMusic: true));
  }
  return box.get(Settings.BOX_KEY)!;
}
