import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/game_play.dart';
import './helpers/settings.dart';

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
      ],
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<Settings>.value(
              value: Provider.of<Settings>(context),
            ),
          ],
          child: child,
        );
      },
      child: MaterialApp(
        home: GamePlay(),
      ),
    ),
  );
}
