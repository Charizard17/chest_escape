import 'package:flutter/material.dart';

import '../game/game.dart';
import 'pause_menu.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  final WallPasserGame gameRef;

  const PauseButton({
    Key? key,
    required this.gameRef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        -1,
        (MediaQuery.of(context).size.height -
                gameRef.gameCanvasSize.y +
                gameRef.gameTopPadding.y +
                60) /
            MediaQuery.of(context).size.height,
      ),
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
