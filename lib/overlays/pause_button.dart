import 'package:flutter/material.dart';

import '../game/game.dart';
import 'pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final ChestEscape gameRef;

  const PauseButton({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 5,
      top: gameRef.gameCanvasSize.y + gameRef.gameTopPadding.y + 5,
      child: IconButton(
        icon: Icon(
          Icons.pause_circle_outline_rounded,
          size: 40,
          color: Colors.amber,
        ),
        onPressed: () {
          gameRef.pauseEngine();
          gameRef.overlays.remove(PauseButton.ID);
          gameRef.overlays.add(PauseMenu.ID);
        },
      ),
    );
  }
}
