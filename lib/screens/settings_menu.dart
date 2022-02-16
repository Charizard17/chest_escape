import 'package:flutter/material.dart';

import './main_menu.dart';
import '../game/game.dart';

class SettingsMenu extends StatelessWidget {
  static const String ID = 'SettingsMenu';
  final WallPasserGame gameRef;

  const SettingsMenu({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black.withOpacity(0.8),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
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
                    SwitchListTile(
                      title: Text(
                        'Sound Effects',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      activeColor: Colors.amber,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.black,
                      value: true,
                      onChanged: (_) {},
                    ),
                    SwitchListTile(
                      title: Text(
                        'Background Music',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                        ),
                      ),
                      activeColor: Colors.amber,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.black,
                      value: true,
                      onChanged: (_) {},
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
                    size: 30,
                  ),
                  label: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
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
