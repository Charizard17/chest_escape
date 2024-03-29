import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './main_menu.dart';
import '../game/game.dart';
import '../models/settings.dart';

class SettingsMenu extends StatelessWidget {
  static const String ID = 'SettingsMenu';
  final ChestEscape gameRef;

  const SettingsMenu({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.9, 0.1),
              colors: [
                Colors.grey,
                Colors.black,
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Selector<Settings, bool>(
                      selector: (context, settings) => settings.backgroundMusic,
                      builder: (context, backgroundMusic, _) {
                        return SwitchListTile(
                          title: Text(
                            'Background Music',
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  backgroundMusic ? Colors.amber : Colors.grey,
                            ),
                          ),
                          activeColor: Colors.amber,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.black,
                          value: backgroundMusic,
                          onChanged: (bool newValue) {
                            Provider.of<Settings>(context, listen: false)
                                .backgroundMusic = newValue;
                            if (newValue == true) {
                              gameRef.audioManager
                                  .playBackgroundMusic('SynthBomb.mp3');
                            }
                            if (newValue == false) {
                              gameRef.audioManager.stopBackgroundMusic();
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Selector<Settings, bool>(
                      selector: (context, settings) => settings.soundEffects,
                      builder: (context, soundEffects, _) {
                        return SwitchListTile(
                          title: Text(
                            'Sound Effects',
                            style: TextStyle(
                              fontSize: 18,
                              color: soundEffects ? Colors.amber : Colors.grey,
                            ),
                          ),
                          activeColor: Colors.amber,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.black,
                          value: soundEffects,
                          onChanged: (bool newValue) {
                            Provider.of<Settings>(context, listen: false)
                                .soundEffects = newValue;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.12,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    color: Colors.black,
                    size: 35,
                  ),
                  label: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () {
                    gameRef.overlays.remove(SettingsMenu.ID);
                    gameRef.overlays.add(MainMenu.ID);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
